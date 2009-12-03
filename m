From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] pull: clarify advice for the unconfigured error case
Date: Wed, 2 Dec 2009 19:26:14 -0600
Message-ID: <20091203012535.GA16259@progeny.tock>
References: <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
 <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron>
 <20091113040754.GA3255@progeny.tock>
 <20091127141704.GA24080@progeny.tock>
 <7vk4x57z4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 03 02:19:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NG0Lh-0005PX-56
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 02:19:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZLCBTA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Dec 2009 20:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753108AbZLCBTA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 20:19:00 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:61474 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbZLCBS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 20:18:59 -0500
Received: by yxe17 with SMTP id 17so722967yxe.33
        for <git@vger.kernel.org>; Wed, 02 Dec 2009 17:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=vxR/j4tvKHgE73vEbFaoJ07JNk5GdwyEZyJzJnUVJiY=;
        b=yDrlgsKmkNu87szJ+pPD7zDbMy7AWOALn87T0ViSvYTXUWuoz1Wnf1xIVNa1d+PgcV
         rJO3pTtK2XbXsMhXM6GBF/SR18mkoPVmO6xh8ldsIEAP80oUZrJizUVwo1Y1MxQ7cU5/
         3QVmsAzI4CF6FEeVgAzhm+iuwM5nKp0k4Pr1s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uBhJB1yBlLNypVi9Vnrdt+kBAycYsEcUxBtgDcw4lZGngSY7tovjsAbOrEbMu40shH
         YDnEsXEza/QW+6pPMWSkFNi7BK4hQ+vJjZR8oSIo0rKyPlCW1SFN8x6Yt2vUievOe+oM
         6tB9QhD52avJF2JJg31qNQdCQcWmLUsgeKUOw=
Received: by 10.90.10.9 with SMTP id 9mr1296985agj.69.1259802813847;
        Wed, 02 Dec 2009 17:13:33 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm242596iwn.11.2009.12.02.17.13.32
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Dec 2009 17:13:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vk4x57z4e.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134421>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> From: Jan Kr=C3=BCger <jk@jk.gs>
>>
>> When pull --rebase fails because it cannot find what branch to
>> merge against, the error message implies we are trying to merge.
>> Say "rebase against" instead of "merge with" to avoid confusion.
[...]
> Is this a good replacement for 31971b3 (git-pull.sh --rebase: overhau=
l
> error handling when no candidates are found, 2009-11-12) that is on '=
pu'

Yes, that is the intent.

> and does the lack of follow-up mean everybody involved in the discuss=
ion
> is happy with this version?

I=E2=80=99m not sure.  I know I like it. :-)

I was the only one with nitpicks about the wording (sorry).  Re
whether to use configuration file syntax or a 'git config' command
line snippet, it seemed like there was some consensus once it was
clear that the user would have to modify the lines anyway to fill in
the right values.  But others can speak up if this seems wrong.

Hope that helps,
Jonathan
