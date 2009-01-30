From: =?ISO-8859-1?Q?Jonas_Flod=E9n?= <jonas.floden@gmail.com>
Subject: Re: [PATCH] Quick and dirty mergetool fix
Date: Fri, 30 Jan 2009 17:00:27 +0100
Message-ID: <4983241B.6020208@gmail.com>
References: <20090130140615.GA26321@hashpling.org> <1233325351-31496-1-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jan 30 17:02:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSvoc-0001zR-6D
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 17:01:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbZA3QAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 11:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbZA3QAd
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 11:00:33 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:46935 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbZA3QAd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 11:00:33 -0500
Received: by ewy14 with SMTP id 14so844202ewy.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 08:00:31 -0800 (PST)
Received: by 10.210.28.4 with SMTP id b4mr1547972ebb.38.1233331230925;
        Fri, 30 Jan 2009 08:00:30 -0800 (PST)
Received: from ?192.168.0.40? (c-10a5e155.260-1-64736c10.cust.bredbandsbolaget.se [85.225.165.16])
        by mx.google.com with ESMTPS id 10sm1339294eyz.50.2009.01.30.08.00.29
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 08:00:30 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <1233325351-31496-1-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107835>

Hmm, with that patch I get get this instead:

mv: cannot stat `.merge_file_Yg2IIs': No such file or directory
mv: cannot stat `.merge_file_4xGT8t': No such file or directory
mv: cannot stat `.merge_file_4XAVAt': No such file or directory

Which seems to be a problem in checkout_staged_file()

The .merge_file_* files exists in the repository root (the dir with
.git) but I don't know how to fix that..

Thanks!

// Jonas
