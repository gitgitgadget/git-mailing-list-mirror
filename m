From: Alexander Miseler <alexander@miseler.de>
Subject: Re: Summer of Code project ideas due this Friday
Date: Thu, 10 Mar 2011 22:43:39 +0100
Message-ID: <4D79460B.1000408@miseler.de>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com> <20110303185918.GA18503@sigill.intra.peff.net> <AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com> <20110303203323.GA21102@sigill.intra.peff.net> <20110309174956.GA22683@sigill.intra.peff.net> <AANLkTinpAOE06YX-m=ptQM_y-QMGpVmjewDxWopkXJkQ@mail.gmail.com> <20110309215841.GC4400@sigill.intra.peff.net> <20110310001017.GA24169@elie> <20110310163011.GA17137@sigill.intra.peff.net> <AANLkTinv-CQ4TKQu8T8o6K5aJ3ivdrScPN0shF=ma9Oz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Mar 10 22:43:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxne2-0000wB-T4
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 22:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab1CJVni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 16:43:38 -0500
Received: from moutng.kundenserver.de ([212.227.17.9]:58401 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab1CJVnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 16:43:37 -0500
Received: from [192.168.22.13] (f055053254.adsl.alicedsl.de [78.55.53.254])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MWhTP-1PR4Fp0cKB-00Xubl; Thu, 10 Mar 2011 22:43:34 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <AANLkTinv-CQ4TKQu8T8o6K5aJ3ivdrScPN0shF=ma9Oz@mail.gmail.com>
X-Provags-ID: V02:K0:anqBGL2btkWfkeBlf++EA//Co63C9diOsaqdNzX35tE
 9qK+1NfhZLzMdEU4sQ8tewDhVZZOoLgC6oQyt9CEgA1KBQo1yU
 eHSjQqcdpK0MT/Os8W8oiMRmflZZFpnafFuyiurZnYMFyWiJjw
 96fyBFmZEWu/9xQSqkA6OsTDdoCq6OpbX0Kb45DqS7QQb0sJoF
 TvBzn7ZMcErrRn5Fr/7wg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168854>

On 10.03.2011 18:31, Shawn Pearce wrote:
> On Thu, Mar 10, 2011 at 08:30, Jeff King <peff@peff.net> wrote:
>>
>>> 7. packfilev4.
>>
>> I suspect that is too complex for a SoC project. But you never know.
> 
> It is. Nico is also probably working on it.
> 
> My big concern with pack v4 right now is the on-disk format of
> commits/trees is different from the current wire protocol. If a pack
> v2 only client connected to a server using pack v4, the server would
> have to spend a lot of time to inflate/deflate about 60% of the
> objects in the repository (commits and trees). That is a lot of CPU
> time. So even if a SoC-er finished the work, it probably wouldn't be
> merged because of this penalty.

I'm very interested in this. Can anyone please point me towards further information on the packfile format and proposed/in-progress changes?
