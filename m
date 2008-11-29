From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Sat, 29 Nov 2008 20:02:12 +0700
Message-ID: <fcaeb9bf0811290502j5db4056fo9b125aaa8b564314@mail.gmail.com>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
	 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
	 <20081128192033.GF23984@spearce.org>
	 <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
	 <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 14:03:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6PTx-00021T-0E
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 14:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbYK2NCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 08:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbYK2NCP
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 08:02:15 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:16727 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYK2NCN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 08:02:13 -0500
Received: by fg-out-1718.google.com with SMTP id 19so1258785fgg.17
        for <git@vger.kernel.org>; Sat, 29 Nov 2008 05:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aS2ySF6fz+trzM8lCijcOnzNA/3uIHmMtzp5oxLhtRs=;
        b=eLLAQAe+fpdovTKVjcWZ3Gy01AVV4uFNSiEyw9Z8jh/cW9RyzQVSeuUPHUm4JpCwDf
         gIdVgVfIpLEeYWYJsZQM0jDux6uUZns1CHoD+HRC4nXsJXVNMJI82WRYTormZe9udQb8
         AZIf0Y56rjkxN3ZO70qTvdtmCU1UYfHS8iwoA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=mYc3TpJBusEQTKR8AQzEEDUSWXxKjQDpwP+X7yQdb/fko0K5jtXwnyzIgnu9k2cIQ1
         hAO/P3svtGB8bWVrxZTxbgoQE/JCwavu3K8VZQt9ljCFZwnvSxSbZHVWOBbbeVPTbNyl
         SmjsyytU81c//vp+2ON+szdqBTIzxLfMZ9srw=
Received: by 10.86.79.19 with SMTP id c19mr5677711fgb.26.1227963732135;
        Sat, 29 Nov 2008 05:02:12 -0800 (PST)
Received: by 10.86.62.13 with HTTP; Sat, 29 Nov 2008 05:02:12 -0800 (PST)
In-Reply-To: <alpine.LNX.1.00.0811281938250.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101909>

On 11/29/08, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 28 Nov 2008, Junio C Hamano wrote:
>
>  > "Shawn O. Pearce" <spearce@spearce.org> writes:
>  >
>  > > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > > ...
>  > >> In other words, unless there is more interest in that feature, enough to
>  > >> generate a well-understood design before a good implementation, I'd rather
>  > >> see this patch series dropped.
>  > >
>  > > Ack.  I agree with every remark made by Dscho, and also want to cry "wolf".
>  > >
>  > > I haven't had time to read the patch series.  Its big and intrusive
>  > > and I just don't need the feature.
>  >
>  > Well, "me neither".  Although I personally think resisting changes until
>  > it becomes absolutely necessary is a good discipline, we also need to
>  > recognise that there is a chicken-and-egg problem.  When you have a
>  > potentially useful feature, unless people actually try using it in the
>  > field, you won't discover the drawbacks in either the design nor the
>  > implementation, let alone any improvements.
>
>
> I just looked over most of it (skipping the generic index extension
>  portion). It looks to me like it's introducing an extra concept to avoid
>  actually fixing maybe-bugs in the "assume unchanged" implementation
>  when used with files that have been changed intentionally (with the user
>  intending git to overlook this change). Sparse checkout is essentially a
>  special case of this, where the user has changed the working directory
>  radically (not populating it at all) and wants git to carry on as if this
>  was not the case (with a certain amount of porcelain code to cause this to
>  happen automatically).

I chose to use another bit because I did not want to change the
behaviour of CE_VALID bit: it assumes all files are present.

>  If there's any need for this to be distinguished from "assume unchanged",
>  I think it should be used with, not instead of, the CE_VALID bit; and it
>  could probably use some bit in the stat info section, since we don't need
>  stat info if we know by assumption that the entry is valid.

Interesting. I'll think more about this.

>         -Daniel
>  *This .sig left intentionally blank*
>
> --
>  To unsubscribe from this list: send the line "unsubscribe git" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy
