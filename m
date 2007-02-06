From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Documentation: add KMail in SubmittingPatches
Date: Tue, 6 Feb 2007 14:47:49 +0000
Message-ID: <200702061447.51459.andyparkins@gmail.com>
References: <7v1wl7bv66.fsf@assigned-by-dhcp.cox.net> <200702051427.32532.barra_cuda@katamail.com> <7vveigkmpv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Michael <barra_cuda@katamail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 15:48:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HERc9-0004Es-43
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 15:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbXBFOr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 09:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752212AbXBFOr7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 09:47:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:47023 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbXBFOr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 09:47:58 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1623853uga
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 06:47:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cwHxKt6CcBDCtpkYzICfYp+MEPkvXlJKi7ThJnFbWWmGyjt5HnRwPRw+eY5yJs1AbzgkN2nRSWP0HUHYqsbaMRuenTEThhf9Hogo0u6GHFlTZtCB2F6KeOPtSY+22E56r8IhbE618K9iWn0rf62f0kdVNfW4bQjff0NspGyNARA=
Received: by 10.67.119.9 with SMTP id w9mr9742564ugm.1170773277366;
        Tue, 06 Feb 2007 06:47:57 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l33sm9770203ugc.2007.02.06.06.47.54;
        Tue, 06 Feb 2007 06:47:54 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7vveigkmpv.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38844>

On Tuesday 2007 February 06 03:07, Junio C Hamano wrote:

> I do not use KMail myself, so I cannot comment on the procedure,
> but from the cursory look it *should* do the right thing.  Only
> that it makes me a bit nervous to see your hunk header being
> line wrapped.

I use Kmail for submitting patches, and it seems to work okay.  The important 
thing is to turn word wrap off as soon as you open it.  If you did this:

 * Save patch as draft (say with git-imap-send)
 * Open draft
 * Close draft
 * Open draft
 * Turn word wrap off
 * Send

You would have a badly wrapped patch.  The reason is that until you store the 
email again, kmail seems to know the difference between a hard LF that was in 
the original email and a LF that it inserted to wrap the lines.  So, as soon 
as you turn word wrap off all the soft LFs go away - perfect.  However, if 
you save without turning word wrap off, all those soft LFs become hard and 
the next time you open the email there is no easy way to get the untouched 
email back.

Michael's original instructions seem fine though.  I don't think his word wrap 
problem in this case is the work of KMail.



Andy

-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
