X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [RFC] E-mail aliases
Date: Tue, 12 Dec 2006 12:49:26 +0000
Message-ID: <b0943d9e0612120449k4a13ac85t313df1e460ed46e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 12:49:34 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pVHAfSqph+6aSX94Y0LHV6Oq14cEBKOv4shzJYeNqlfkf2cRFME1i3qjPbvdDMu51JpyHQbXLfB0wj/jaZttYd1M4dZA5J5UFl9kTmU66GjGVmhhr50GIZ/YYeP95o+t5syNwFjuKx2wtO331MmODN1m3OyRMKEwbaQwqoHYap8=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34094>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu74c-0002xe-Ts for gcvg-git@gmane.org; Tue, 12 Dec
 2006 13:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751283AbWLLMt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 07:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWLLMt2
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 07:49:28 -0500
Received: from nz-out-0506.google.com ([64.233.162.235]:24788 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1751283AbWLLMt1 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 07:49:27 -0500
Received: by nz-out-0102.google.com with SMTP id s1so975756nze for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 04:49:27 -0800 (PST)
Received: by 10.64.180.4 with SMTP id c4mr10208171qbf.1165927766072; Tue, 12
 Dec 2006 04:49:26 -0800 (PST)
Received: by 10.65.126.2 with HTTP; Tue, 12 Dec 2006 04:49:26 -0800 (PST)
To: "GIT list" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hi,

I added a feature to StGIT (not released yet) so that one can specify
an alias instead of a complete e-mail address on the command line (or
in the template file), i.e.:

  stg mail --to=lkml

sets the "To:" header to "linux-kernel@vger.kernel.org".

The aliases are read from the [aliases] section in the gitconfig files
("git repo-config aliases.lkml" in this case). I just want to make
sure than there isn't any other intended use for the [aliases] section
in the config files.

Thanks.

-- 
