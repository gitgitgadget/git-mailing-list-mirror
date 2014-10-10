From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2 1/2] mergetool: don't require a work tree for --tool-help
Date: Fri, 10 Oct 2014 10:01:57 +0100
Message-ID: <FCAAE5E4-E220-4B45-A6A1-B2AFB79F9069@hashpling.org>
References: <1412931104-74648-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Charles Bailey <cbailey32@bloomberg.net>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 11:10:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcWDs-0006Oy-8W
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 11:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbaJJJKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 05:10:49 -0400
Received: from host02.zombieandprude.com ([80.82.119.138]:49280 "EHLO
	host02.zombieandprude.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774AbaJJJKs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Oct 2014 05:10:48 -0400
Received: from [62.189.9.199] (port=21565 helo=[10.255.82.95])
	by host02.zombieandprude.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <charles@hashpling.org>)
	id 1XcW5E-0004Pi-8e; Fri, 10 Oct 2014 10:01:56 +0100
X-Mailer: iPhone Mail (12A405)
In-Reply-To: <1412931104-74648-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 Oct 2014, at 09:51, David Aguilar <davvid@gmail.com> wrote:
> Changes since v1:
> 
> NONGIT_OK=Yes was added to make it actually work outside of a git repo.

Does this actually work? The reason that I haven't got around to resending my re-roll is that I found that I needed changes to git-sh-setup.sh because doing NONGIT_OK and then require_work_tree didn't correctly set GIT_DIR when it wasn't already explicitly set in the environment. (I believe the rest of mergetool relies on it.)

Perhaps I misunderstood, though.