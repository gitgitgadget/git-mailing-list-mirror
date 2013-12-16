From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] pack-objects: name pack files after trailer hash
Date: Mon, 16 Dec 2013 08:41:38 +0100
Message-ID: <52AEAEB2.6060203@alum.mit.edu>
References: <CACsJy8DbJZmBCnfzNqfmEnRpqVcc42Q_-jz3r=sYVRPhsCkS5A@mail.gmail.com> <5297004F.4090003@gmail.com> <CACsJy8AdOAPT-RfD0NfZj_cQPBSUrVKn8yS7JRe=-4k8C8TvQg@mail.gmail.com> <211D44CB-64A2-4FCA-B4A7-40845B97E9A1@ancientrocklab.com> <CACsJy8AOVWF2HssWNeYkVvYdmAXJOQ8HOehxJ0wpBFchA87ZWw@mail.gmail.com> <20131128092935.GC11444@sigill.intra.peff.net> <CAJo=hJuBTjGfF2PvaCn_v4hy4qDfFyB=FXbY0=Oz3hcE0L=L4Q@mail.gmail.com> <20131204200850.GB16603@sigill.intra.peff.net> <CAJo=hJuRz9Qc8ztQATkEs8huDfiANMA6gZEOapoofVdoY82k4g@mail.gmail.com> <20131205160418.GA27869@sigill.intra.peff.net> <20131205202807.GA19042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 16 08:49:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsSvD-0008FD-Tv
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 08:49:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab3LPHsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 02:48:45 -0500
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:48215 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751095Ab3LPHsp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Dec 2013 02:48:45 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2013 02:48:44 EST
X-AuditID: 12074412-b7fc96d0000023d5-70-52aeaeb6353e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id EF.96.09173.6BEAEA25; Mon, 16 Dec 2013 02:41:42 -0500 (EST)
Received: from [192.168.69.148] (p57A24647.dip0.t-ipconnect.de [87.162.70.71])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id rBG7fdfY009957
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 16 Dec 2013 02:41:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131005 Icedove/17.0.9
In-Reply-To: <20131205202807.GA19042@sigill.intra.peff.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqLtt3bogg31rrC26rnQzWfxo6WG2
	mH9oIqsDs8ez3j2MHn/O72H1+LxJLoA5itsmKbGkLDgzPU/fLoE74137U5aCxRwVSyZcYGpg
	PM/WxcjBISFgItHX6dDFyAlkiklcuLceKMzFISRwmVFi1ZuvrBDOOSaJjkP9TCBVvALaEp+m
	trGDNLMIqEr8OhcJEmYT0JVY1NMMViIqECTx6NBDdohyQYmTM5+wgNgiArIS3w9vZASxmQX8
	JFb8/AVWIyzgKrHq52moxd9ZJBavvM0MkuAUsJbYtmkeC8Sh4hI9jUEgJrOAusT6eUIQY+Ql
	tr+dwzyBUXAWkm2zEKpmIalawMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXTC83s0QvNaV0
	EyMknIV2MK4/KXeIUYCDUYmHV8FyXZAQa2JZcWXuIUZJDiYlUd6Jc4FCfEn5KZUZicUZ8UWl
	OanFhxglOJiVRHhjrq4NEuJNSaysSi3Kh0lJc7AoifP+XKzuJySQnliSmp2aWpBaBJOV4eBQ
	kuAVAMatkGBRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoduOLgdELkuIB2gvWzltc
	kJgLFIVoPcWoyzHvy4dvjEIsefl5qVLivC/WAhUJgBRllObBrYAlr1eM4kAfC/M+B6niASY+
	uEmvgJYwAS15vgZsSUkiQkqqgXHXvCRP1U1GVo/8d5n4CxyacYvv2+I3j7Z2ePhtUZjI2nVL
	UFFCO//8/R8fJd6qvK07WrCbyfvA4UXSYSYcwTs2cJ6+MGNr9t1n/NG3q62Xml8r 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239331>

On 12/05/2013 09:28 PM, Jeff King wrote:
> [...]
> This patch simply uses the pack trailer sha1 as the pack
> name. It should be similarly unique, but covers the exact
> representation of the objects. Other parts of git should not
> care, as the pack name is returned by pack-objects and is
> essentially opaque.
> [...]

Peff,

The old naming scheme is documented in
Documentation/git-pack-objects.txt, under "OPTIONS" -> "base-name":

> base-name::
> 	Write into a pair of files (.pack and .idx), using
> 	<base-name> to determine the name of the created file.
> 	When this option is used, the two files are written in
> 	<base-name>-<SHA-1>.{pack,idx} files.  <SHA-1> is a hash
> 	of the sorted object names to make the resulting filename
> 	based on the pack content, and written to the standard
> 	output of the command.

The documentation should either be updated or the description of the
naming scheme should be removed altogether.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
