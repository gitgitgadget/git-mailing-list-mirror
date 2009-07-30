From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: Re: [PATCH] Translate the tutorial to Brazillian Portuguese.
Date: Thu, 30 Jul 2009 00:26:14 -0300
Message-ID: <b8bf37780907292026q61805aadhd2019eae77739c47@mail.gmail.com>
References: <7vljnbcbjs.fsf@alter.siamese.dyndns.org>
	 <1246289542-1596-1-git-send-email-cascardo@holoscopio.com>
	 <7vfxdjc9b3.fsf@alter.siamese.dyndns.org>
	 <20090629162738.GE4327@vespa.holoscopio.com>
	 <7vtz1yc2i3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Yasuaki Narita <yasuaki_n@mti.biglobe.ne.jp>
To: Junio C Hamano <gitster@pobox.com>,
	Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 05:32:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWMNr-0008HH-P0
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 05:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754081AbZG3Dcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 23:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754022AbZG3Dcg
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 23:32:36 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:34529 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbZG3Dcf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 23:32:35 -0400
Received: by qyk34 with SMTP id 34so504377qyk.33
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 20:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yI9a4jkj+ix7NdO9oUuweJ1B5MWLzgqXfw6G8ZlpY7s=;
        b=ulz3k6GEw9J+pJYnXvX4tocm7o8N3uMJdwV/TzqCH5S23Y/PMxlZ62K/sU+tgIefI1
         bkvTVBnBo5GacTYx+wog7f68N91RJR+hxWrg8m/2lB/vqSlwxTClad7xQ7qbcF+j1Xp5
         ns//RaOGCcUbo1p5DjD5MVKgd+3PS9Q3Woeoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bDdgFvM7vDsfJLk9vU+uXxbiR/XF/xvhm1Msgx4Fx0ls9zjY76r9tOELcr44aIfU94
         7NsVDmTCEGfk+Zlm4rLgKjzmSO0RUlJa73hSGZlnfcVCTshpcakL4owwBDhDOV2Ree8g
         GMcY5vbVY3AkCP7RtUlpWOBu39F/y98bvamyY=
Received: by 10.220.46.10 with SMTP id h10mr840896vcf.8.1248924374220; Wed, 29 
	Jul 2009 20:26:14 -0700 (PDT)
In-Reply-To: <7vtz1yc2i3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124439>

>> I think that using something like po would be better. There are tools
>> that can extract and update the template messages from many differente
>> sources. Adapting them to produce a template file from gittutorial.txt
>> would allow translators to verify how stale their translations are and
>> much smoother merges. How about that?
>
> After thinking about it a bit more, I think I would prefer something that
> keeps translation sources separate from the original text.  That way, I
> have a lot less chance of having to deal with merge/patch conflicts.
>
> Your patch adds Documentation/pt/ hierarchy, but I noticed that the kernel
> folks seem to use Documentation/{ja_JP,ko_KR,zh_CN}/.  I do not think it
> would make much difference for Japanese language between ja vs ja_JP, but
> for many languages used in different geographic areas, such an arrangement
> would make a lot more sense.  As your patch identified itself as a
> translation to "Brasilian Portuguese", I am imagining that it would be
> sufficiently different to merit the distinction from Old-world Portuguese.
> Perhaps your patch should be made to Documentation/pt_BR instead?
>
> As to the choice of the tool, from a quick superficial glance, po4a could
> be a reasonable choice, but I do not know how mature and/or widely used it
> is, or if there are better alternatives.  http://po4a.alioth.debian.org/
> says it does support AsciiDoc.

git gui uses 'po' at http://repo.or.cz/w/git-gui/git-gui-i18n.git to
handle all translations, including Brazilian Portuguese.

In the meantime, I've made some translation improvements over Thadeu's
translation work, fixing some typos overall. I'll send it as a
separate patch.

@Thadeu: would you please double check it and perhaps add your Acked-by?

Thanks,
Andre
