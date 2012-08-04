From: Ilya Basin <basinilya@gmail.com>
Subject: Re: git cvsexportcommit: error patch does not apply
Date: Sat, 4 Aug 2012 13:05:05 +0400
Message-ID: <1029867674.20120804130505@gmail.com>
References: <999213645.20120803130555@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 11:04:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxaHU-0000Wr-Cd
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 11:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab2HDJEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 05:04:15 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:51915 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab2HDJEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 05:04:14 -0400
Received: by lbbgm6 with SMTP id gm6so2037910lbb.19
        for <git@vger.kernel.org>; Sat, 04 Aug 2012 02:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=CccNyZhElvn48vyg5bH07rf/++c7GLQSDnsFUq/86Bw=;
        b=xrFS8A/ffLWbHaKUavL+0zoeBJEsPm62Znr7k8M5fS/PUbFZCddqDCtcufLjJNJ6aW
         2tzg8XX3NpcoPUzY6MiaLGLlvzHUYl3wWMhsY6FOKW5Kk1e2lNlmOZycxUXrEJLYWEwh
         jP1mNRUespWSTjfVZ2XD9oCcASWEyT4VINP4JLUOdPARJiwB8grVc4m8n0+w44or7yQU
         VpR+fZIQ9xNToR2sJfhKnUp8dvrDTM/2bj3eWbPBnyxAT22/DvVU6KbXPf0lwOQeN0YF
         bUFF0/GY/fdRrHfMruQVVIRlwEmV0fErNJA4eLcJTxIfq8OZE9sE3RTfjTnmq3ieb7GA
         0vTg==
Received: by 10.112.17.227 with SMTP id r3mr1781710lbd.41.1344071052818;
        Sat, 04 Aug 2012 02:04:12 -0700 (PDT)
Received: from MAR2.localnet (ppp91-122-17-72.pppoe.avangarddsl.ru. [91.122.17.72])
        by mx.google.com with ESMTPS id d3sm2475797lbh.3.2012.08.04.02.04.10
        (version=SSLv3 cipher=OTHER);
        Sat, 04 Aug 2012 02:04:11 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <999213645.20120803130555@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202874>

IB>     $ git cvsexportcommit -w ../../cvs/SAP -u -p -k -c b04fa43c9f1374cf0ea5f9bf88024282414b0a0c
IB>     Checking if patch will apply
IB>     cvs update: nothing known about `documentation/SIC_SAP1_0_ADM_dv1_2.doc'
IB>     cvs status: nothing known about `documentation/SIC_SAP1_0_ADM_dv1_2.doc'
IB>     Huh? Status 'Unknown' reported for unexpected file 'no file SIC_SAP1_0_ADM_dv1_2.doc'
IB>     Applying
IB>     error: the patch applies to 'documentation/SIC_SAP1_0_ADM_dv1_1.doc' (e0c6cf56bd58ce3b1a8b8e00bfd20f75f89110f7), which does not match the current contents.
IB>     error: documentation/SIC_SAP1_0_ADM_dv1_1.doc: patch does not apply
IB>     cannot patch at /usr/lib/git-core/git-cvsexportcommit line 333.

Removing '-k' helped. I think it's a bug.
'-k' should not affect binary files.


-- 
