From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH (GITK,GIT-GUI,DOCS) 2/7] gitk: Support calling git gui
 blame from gitk.
Date: Tue, 26 Aug 2008 14:10:33 +0200
Message-ID: <48B3F2B9.4030403@viscovery.net>
References: <200808231225.12596.angavrilov@gmail.com>	<200808231227.45013.angavrilov@gmail.com>	<200808231229.09191.angavrilov@gmail.com> <18611.55963.306938.896762@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 14:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXxOh-0001f3-SB
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 14:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262AbYHZMKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 08:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbYHZMKj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 08:10:39 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31020 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbYHZMKj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 08:10:39 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KXxNZ-0000xK-KP; Tue, 26 Aug 2008 14:10:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5EBDB54D; Tue, 26 Aug 2008 14:10:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <18611.55963.306938.896762@cargo.ozlabs.ibm.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93739>

Paul Mackerras schrieb:
> Alexander Gavrilov writes:
> 
>> Add a new item to the file list popup menu, that
>> calls git gui blame for the selected file, starting
>> with the first parent of the current commit.
> 
> Also applied, also with some edits to the description.
> 
>> +    $flist_menu add command -label [mc "Blame parent commit"] \
>> +        -command {external_blame 1}
> 
> Why the parent commit rather than the current commit?

For the lines that the current commit *adds*, you know who is to blame
(the current commit). Once you know that, you are usually interested in
who is to blame for the lines that the current commit *removed*. To get
this information, you must "Blame the parent commit".

-- Hannes
