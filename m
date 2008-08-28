From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 11:57:56 +0300
Message-ID: <94a0d4530808280157p230d289dlf0c85cd517541801@mail.gmail.com>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <7vy72kek6y.fsf@gitster.siamese.dyndns.org>
	 <20080826145719.GB5046@coredump.intra.peff.net>
	 <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
	 <20080827001705.GG23698@parisc-linux.org>
	 <7v63pmkozh.fsf@gitster.siamese.dyndns.org>
	 <1219907659.7107.230.camel@pmac.infradead.org>
	 <7vtzd5fta0.fsf@gitster.siamese.dyndns.org>
	 <1219912327.7107.245.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, "Jeff King" <peff@peff.net>,
	"Matthew Wilcox" <matthew@wil.cx>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	users@kernel.org
To: "David Woodhouse" <dwmw2@infradead.org>
X-From: git-owner@vger.kernel.org Thu Aug 28 10:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYdLL-0003ku-Eo
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 10:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbYH1I56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 04:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbYH1I56
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 04:57:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:20700 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbYH1I55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 04:57:57 -0400
Received: by rv-out-0506.google.com with SMTP id k40so297966rvb.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=/ytW8a3qqAVmHh5dOr5gN0eG1a/2bzOsviBir3ANtPc=;
        b=v22/hEt1fzUYJ4erOLI+YxdtRz99TfTLOejWC6GY0dWC4ZPisrcLR2Fjgn93OaTyFA
         gHzlrBof+z+HmgGn8d7KjJ/8gVKLXtM5mExt/1OGW8hSt5HFL+Avu2NjNsw0yma2Fgy+
         YX/sCREX7Tokd1cPPXvtaOEOl+zIeZe23/8gA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UjU8dg3XFAP5cy9+xeS+LbIR1BPgwiJVxROjBg8YFVohuQISeSt1gwjH76b2gv9C5B
         XgV+5IO9T/JDtnsLpwK8/0dtpaxt5xzwnOcUZuaYFm3TSPueaDHPWLIQ5pPBsl/mMp9G
         JuceAbiW1V+YxqYZQoKsUEJGtExcz4/rtIj9w=
Received: by 10.141.44.13 with SMTP id w13mr605633rvj.13.1219913876903;
        Thu, 28 Aug 2008 01:57:56 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Thu, 28 Aug 2008 01:57:56 -0700 (PDT)
In-Reply-To: <1219912327.7107.245.camel@pmac.infradead.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 28, 2008 at 11:32 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Thu, 2008-08-28 at 01:17 -0700, Junio C Hamano wrote:
>> David Woodhouse <dwmw2@infradead.org> writes:
>>
>> > Excellent. All we need to do is make sure the distributions all set
>> > $(gitexecdir) to /usr/bin when they upgrade to 1.6.0 -- and could you
>> > also fix it on master.kernel.org please?
>>
>> Are you trying to irritate me even more?
>
> Not at all; I'm sorry if that's the effect.
>
>> Although I personally did not particularly like the "out of /usr/bin" move,
>> this was done by user request.  I now am hated for doing something I was
>> dragged into doing, not because I wanted the change, but only because many
>> others wanted it, and you are dreaming that another pointless change will
>> be made in the other direction?
>
> I'm not asking you to make another change in upstream git. You've told
> us the workaround (gitexecdir=/usr/bin), and that workaround is no
> longer going to be deprecated, which is great. It's just up to us to
> ensure that we use that workaround when we build git for ourselves, and
> to ensure that our distributions also build packages using that
> workaround.
>
> Since I believe you're building the git packages used on kernel.org, I
> was just asking you to apply the workaround when you build _those_
> packages, that's all.

You are getting it wrong.

If *you* want the git-foo form, then *you* add the git exec dir to your PATH.

The masses should forget about the git-foo form. If you push people
into using git-foo then you are not following git guidelines; you
would be pushing your own agenda.

-- 
Felipe Contreras
