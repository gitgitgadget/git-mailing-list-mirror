From: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
Subject: Prompt for merge message?
Date: Thu, 6 Oct 2011 10:49:02 -0700 (PDT)
Message-ID: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 19:59:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsE0-0000kJ-Js
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:59:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758808Ab1JFR7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:59:09 -0400
Received: from mail-yw0-f56.google.com ([209.85.213.56]:62254 "EHLO
	mail-yw0-f56.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1JFR7I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:59:08 -0400
Received: by ywt32 with SMTP id 32so5010347ywt.1
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:59:07 -0700 (PDT)
Received: by 10.101.81.20 with SMTP id i20mr211208anl.26.1317923342938; Thu,
 06 Oct 2011 10:49:02 -0700 (PDT)
Received: by t11g2000yqk.googlegroups.com with HTTP; Thu, 6 Oct 2011 10:49:02
 -0700 (PDT)
User-Agent: G2/1.0
X-Google-Web-Client: true
X-Google-Header-Order: HUALESNKRC
X-HTTP-UserAgent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0.1) Gecko/20100101 Firefox/7.0.1,gzip(gfe)
X-Google-IP: 96.244.66.187
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183003>

I often find myself using "--no-ff -m foo" for merging short-lived
branches, because the merge commit usually needs to say something
about having finished a feature rather than referring to a branch that
will be deleted shortly anyway. However, it's a little annoying to
have to always write the commit message on the command-line,
especially in cases where a more expository multi-line message would
be useful.

Is there currently a way to get git to prompt for the merge message,
rather than using the default or requiring the -m flag? If not, isn't
this a common-enough use case to have that ability added to the merge
function?
