From: Chris Packham <judge.packham@gmail.com>
Subject: Re: about directory management
Date: Tue, 19 Jul 2011 19:45:07 +1200
Message-ID: <4E253603.7020403@gmail.com>
References: <20110719113706.0aca61b5@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Tue Jul 19 09:45:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qj4zO-0007TA-M9
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 09:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432Ab1GSHpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 03:45:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60728 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752339Ab1GSHpC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 03:45:02 -0400
Received: by iwn6 with SMTP id 6so3827302iwn.19
        for <git@vger.kernel.org>; Tue, 19 Jul 2011 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=LtkdEStK/3xqc7I6U6agBffEQzLPBpIUWVtEscehUE8=;
        b=XLmJfxgSPvGRpsMD9kfM4TnwcJ4f/+0K+hydk6lvSXc6pRQ6npNkVeB6RMJ04TIhVv
         tbEXCqFR+4rz4hHw+Cqq44ToHuA/97Oud19P9DFugJiSGOejFnj87FZiv+RIhGdsbQ5b
         MFdfjAowLxwBr8DM4+Eg683co5wIUW/Qqlics=
Received: by 10.231.73.138 with SMTP id q10mr6781348ibj.13.1311061501728;
        Tue, 19 Jul 2011 00:45:01 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id er13sm1250388ibb.53.2011.07.19.00.44.59
        (version=SSLv3 cipher=OTHER);
        Tue, 19 Jul 2011 00:45:00 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.18) Gecko/20110616 SUSE/3.1.11 Thunderbird/3.1.11
In-Reply-To: <20110719113706.0aca61b5@shiva.selfip.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177439>

On 19/07/11 18:07, J. Bakshi wrote:
> Hello,
> 
> I need to add directory structure in my git repo where some of the directory are empty but still need to add those to maintain the structure. I also need to add directory as non-recursive, so that I can add the final child directory so get the structure. How can git help to do these ?
> 
> Thanks
> --

One of the things that makes git different from other SCMs is that it
tracks sets of changes (i.e. commits) not individual files/directories.
My initial response is to tell you to create the directories when you've
got something to put into them and not before. If they are needed for
compilation of your code then make it part of the build process. If you
do have a reason for needing empty directories the standard response is
to put a .dummy file in the directory (you only need it in the deepest
directory, not every directory on the path).
