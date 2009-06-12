From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: uncommit
Date: Fri, 12 Jun 2009 11:06:03 -0700
Message-ID: <8c9a060906121106u81d6d7dx845c458b85e9c994@mail.gmail.com>
References: <e4a904790906121102k51c502ech5fb7a1b1763c4657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex K <spaceoutlet@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:06:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFB9K-0001rD-UA
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 20:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933816AbZFLSGW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 14:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933669AbZFLSGV
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 14:06:21 -0400
Received: from mail-pz0-f187.google.com ([209.85.222.187]:51824 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932524AbZFLSGU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 14:06:20 -0400
Received: by pzk17 with SMTP id 17so725050pzk.33
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 11:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zT0fDYlZ63TuWfZPtFclNikjmJTxi9RXPjELU+e1aYI=;
        b=V7irI5YkpPmOCrJvXH9/dIlp/AQUigA67Ays3/poMqiuXu+sJ1OLGPSmvzUp8jaTKW
         FrWCMTCZscAo3iwuUAZeDbBk8h3P/uLrVe7tzcpuSdaj1qqLh/BTMh0b6NCGIvTWDlO/
         4tztyH76vrCjlq+o0vljE+NQZ1Pij/EF9LkXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JEh47Qn96hRp/Bp9L+XX5SMUHI/uXPbH637irRnzC/cZhWXvtsIw5RBm0eRde4ex9S
         a6TnTYlc8L7kPYUAA3KxB1f04Ai+2GYjdgu762jMAmf3RIXTuSIZuFd3Udgs1X4y2brT
         8D89tnXtmfyXrRmUIucixIAGjvj57tC32OiIw=
Received: by 10.142.239.11 with SMTP id m11mr1675761wfh.242.1244829983299; 
	Fri, 12 Jun 2009 11:06:23 -0700 (PDT)
In-Reply-To: <e4a904790906121102k51c502ech5fb7a1b1763c4657@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121439>

On Fri, Jun 12, 2009 at 11:02, Alex K<spaceoutlet@gmail.com> wrote:
> Hello,
>
> Is there any way to uncommit but keeping the files as is in the
> current working directory?
>
> Thank you,
>
> Alex
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>

Take a look at "git reset".  Specifically the --soft flag.
