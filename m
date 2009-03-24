From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/8] docbook: improve css style
Date: Tue, 24 Mar 2009 02:21:22 +0200
Message-ID: <94a0d4530903231721i2a2a6fc1yf54d4303283ec415@mail.gmail.com>
References: <1237745121-6325-1-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-2-git-send-email-felipe.contreras@gmail.com>
	 <1237745121-6325-3-git-send-email-felipe.contreras@gmail.com>
	 <20090323064242.GB1119@coredump.intra.peff.net>
	 <94a0d4530903230331g3b620f80h77e317a09dc5273f@mail.gmail.com>
	 <49C7A8AF.9080500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 01:23:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LluQ3-0003Wt-3T
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 01:23:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZCXAV1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 20:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbZCXAV1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 20:21:27 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:42929 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755324AbZCXAVZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 20:21:25 -0400
Received: by fg-out-1718.google.com with SMTP id e12so594728fga.17
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 17:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=olZvZpgalYhB5br8Z2sdoIn7xOsU5Urhd4tYwvRRXb0=;
        b=yE81pq8VxYvfSw/jMnTZuF1XC1mTArryuRgg+Z6Bytw7p6GNSSbu+YFT+KY2Wyw4TF
         Il0Cp9mZvgmPbRhlnl2K3Q3zHSoN458wM4jULpnhpDbrS2kFB8yjXoS8j18gwep8SE+3
         8p5ouNDHbQaFEfpWKHY1OwjP59RSghHgyUIFA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=s2IwzunCSZX2007fGR3cj5OOcXbe8OfuIa34whaZ3o8zsN5vvQe5lh1WeIG9yOtkbs
         gOB0JHFemMGqdeuRXyO2Gn8qX/Dc7+LXyGbD3U836GDTM8ryxpj1PbV/RTgkx5yQC3Nn
         YUBEIIxMmNC5AV6axj7Csu6eDLL2bJxXUGm7Y=
Received: by 10.86.79.12 with SMTP id c12mr1806566fgb.64.1237854082940; Mon, 
	23 Mar 2009 17:21:22 -0700 (PDT)
In-Reply-To: <49C7A8AF.9080500@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114370>

On Mon, Mar 23, 2009 at 5:20 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Felipe Contreras venit, vidit, dixit 23.03.2009 11:31:
>> On Mon, Mar 23, 2009 at 8:42 AM, Jeff King <peff@peff.net> wrote:
>>> On Sun, Mar 22, 2009 at 08:05:15PM +0200, Felipe Contreras wrote:
>>>
>>>> =C2=A0tt.literal, code.literal {
>>>> =C2=A0 =C2=A0color: navy;
>>>> + =C2=A0font-size: 1em;
>>>> +}
>>>
>>> Isn't 1em already the default size? Or are you trying to override s=
ome
>>> other size specification elsewhere? It's hard to tell what the goal=
 is
>>> because your commit message merely says "improve".
>>
>> That's correct.
>>
>> The problem is that when the user has a different size for the
>> sans-serif and monospace fonts it looks horrible when they are on th=
e
>> same paragraph. I thought 1em did the trick, but you are right, it
>> doesn't.
>>
>> It looks like the only way to fix this is to set absolute sizes.
>>
>
> Also, it seems that everything which is not black is blue, except for
> terms, which are green and slanted. I don't think that looks nice
> together. How about slanted blue?

What's wrong with having 2 colors?

--=20
=46elipe Contreras
