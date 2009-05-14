From: Cory Sharp <cory.sharp@gmail.com>
Subject: Re: [Q] merge squash unexpected conflicts
Date: Wed, 13 May 2009 20:57:43 -0700
Message-ID: <bb9d69200905132057u60adc2f8vb9ba9a35791f72ac@mail.gmail.com>
References: <bb9d69200905131706m61b0dda1xc347ca2e719ec142@mail.gmail.com>
	 <bb9d69200905131942t7a43a29fh9638d2548e9f12dc@mail.gmail.com>
	 <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 05:57:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4S4u-0001HX-LH
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 05:57:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762723AbZEND5o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 23:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762695AbZEND5n
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 23:57:43 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:55365 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753882AbZEND5n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 23:57:43 -0400
Received: by an-out-0708.google.com with SMTP id d40so2016139and.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 20:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pw2HYdXvVo2iaYW67FzTuLMpfhRhSoGRCAf+XkEWZ1o=;
        b=sYN8C+eTEcRo6veKWdBqteSg+jUSMw3ERboJePuxd/33oyM44fculhzPxJZqWSfV2a
         fDSuZ1wt1ODa0X8BtDFv/o0A4Y5ls27HBR+at54NXKfuD+22NPcO3uigEcvsAzk1HPrh
         ouEk/vQ4rE9MpE1TtEC/8A/jRrXO22YbVCOpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uT/qAcAiZkS774ESyHDY7l+6EwQpBAeQ5KHTnavPudjaMHqVlkxLBCw9d1wti16LBG
         yc0xkIB80PHry+p9fTK1UXjZm2NEVXLud+ODWuZCv9HdrVohT6/YPADffRYu7XDakZlJ
         B+kymeF7sSW4hQb/DHtumc7Pf8IfoEoclVmyU=
Received: by 10.100.164.12 with SMTP id m12mr2471683ane.131.1242273463802; 
	Wed, 13 May 2009 20:57:43 -0700 (PDT)
In-Reply-To: <7v4ovo1iap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119129>

On Wed, May 13, 2009 at 8:21 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Cory Sharp <cory.sharp@gmail.com> writes:
>
>> Am I doing something a little wrong or unexpected?=A0 Is there a way
>> around this squash conflict behavior?=A0 This doesn't seem to happen
>> with plain merge without squash.
>
> Of course. =A0That's the whole point of recording a merge as a merge.
>

$ git help merge

  --squash
           Produce the working tree and index state as if a real merge
happened. ... This allows you to create a
           single commit on top of the current branch whose effect is
the same as merging another branch.
