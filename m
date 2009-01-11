From: "Sverre Rabbelier" <srabbelier@gmail.com>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and --prune-empty.
Date: Sun, 11 Jan 2009 15:40:04 +0100
Message-ID: <bd6139dc0901110640l148b00dctd667572e28908f9f@mail.gmail.com>
References: <20081030132623.GC24098@artemis.corp>
	 <1225445204-28000-1-git-send-email-madcoder@debian.org>
	 <7viqr5wgl7.fsf@gitster.siamese.dyndns.org>
	 <20081103092729.GE13930@artemis.corp>
	 <20081103151826.GJ13930@artemis.corp>
	 <76718490901091129q534ca981iac54e0653d76170d@mail.gmail.com>
	 <20090111111800.GA8032@artemis.corp>
	 <alpine.DEB.1.00.0901111433580.3586@pacific.mpi-cbg.de>
	 <20090111142732.GA18484@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jay Soffian" <jaysoffian@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	pasky@suse.cz
To: "Pierre Habouzit" <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Jan 11 15:41:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM1VM-0006Zr-9N
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 15:41:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbZAKOkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 09:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751602AbZAKOkI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 09:40:08 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:32410 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbZAKOkG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 09:40:06 -0500
Received: by yx-out-2324.google.com with SMTP id 8so3289160yxm.1
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 06:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=N5t3S4A3IC7c4tjQ83WA2SIMg0GOGZA3/xlcuJdeiik=;
        b=sl7BRAmkMWRoFMsEti35+Cqffn62axIuM2IeEg1Bmwl2IvusIH1Lg6bJcR2aBeea8d
         kmwHcMcFaD27LJF27UsMdgr3c76ajoOuMyj843B7LA+CfbiqCppQCtKFnCSGzl1IIC73
         R48qZmIopI04xROmAi0IulVzMAjovJ2IGZGdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=mXJi02oQORlnq1jjM76vwaL31973zAcgriirk79wBzDyY8FCZwClWArAIU/m1qAQi9
         x5t/woIyDJHQaa3wiF0Mqu1Iq5S/nZ43A6L1fv3Ce5wrsAdVOQ52pyYqMoa3BscsbthG
         h8MzqMf6WNHa+jRzf7X1tz6WyOfV5cYJlXHC4=
Received: by 10.150.123.18 with SMTP id v18mr8390263ybc.85.1231684804834;
        Sun, 11 Jan 2009 06:40:04 -0800 (PST)
Received: by 10.150.198.12 with HTTP; Sun, 11 Jan 2009 06:40:04 -0800 (PST)
In-Reply-To: <20090111142732.GA18484@artemis.corp>
Content-Disposition: inline
X-Google-Sender-Auth: 485ad41f9247c8d2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105184>

On Sun, Jan 11, 2009 at 15:27, Pierre Habouzit <madcoder@debian.org> wrote:
>> And I suggested to merge the tests with Sverre's patch.  That suggestion
>> also went unaddressed.
>
> I can't find any mails from Sverre in the same thread, but maybe I'm not
> searching in the proper place...

I think my patch is in a different thread as it was a
documentation-only patch, no?

-- 
Cheers,

Sverre Rabbelier
