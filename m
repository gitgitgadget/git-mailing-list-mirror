From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v4 2/4] Add testcases for the --detect-dir-renames
 diffcore flag.
Date: Mon, 4 Oct 2010 20:32:02 +0200
Message-ID: <20101004183202.GU4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <1286138529-6780-3-git-send-email-ydirson@altern.org>
 <AANLkTi=B-aJJ1Q3grmea_YWQCgBkaHoYj0Rym4rqY19C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Yann Dirson <ydirson@free.fr>
To: ?var Arnfj?r? Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:22:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pg4-0002vh-SA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756724Ab0JDSWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:22:11 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:50960 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755256Ab0JDSWK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:22:10 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 01D31D4813B;
	Mon,  4 Oct 2010 20:22:03 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2ppS-0002lF-J5; Mon, 04 Oct 2010 20:32:02 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=B-aJJ1Q3grmea_YWQCgBkaHoYj0Rym4rqY19C@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158084>

On Mon, Oct 04, 2010 at 03:03:35AM +0000, ?var Arnfj?r? Bjarmason wrote:
> > +mkdir a
[...]
> > +sed <a/path0 >a/path3 s/Line/Blurb/
> 
> Should be in a test, see "Put all code inside test_expect_success and
> other assertions." in t/README.

While I can see the value of having everything run from the test
framework, I was thinking it would be even better to have a special
"test_setup" clause, which could be as a first step just an alias to
test_expect_success, but could afterwards gain features such as "not
counted as success, and counted specially when failed", so we get
better stats of the number of failures we get, and so that editor
outlining/folding modes could be developped in a useful fashion.
