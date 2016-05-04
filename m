From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
Date: Wed, 4 May 2016 14:21:58 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605041416030.9313@virtualbox>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com> <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com> <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com> <CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
 <CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com> <alpine.DEB.2.20.1605041304050.9313@virtualbox> <CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 14:22:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axvoi-0005VR-AY
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 14:22:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbcEDMWI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 08:22:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:56302 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215AbcEDMWH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 08:22:07 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LwaMR-1bjHEe2Jyx-018NYz; Wed, 04 May 2016 14:21:59
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:yyHz8ThReIm11JXqmRQ8wVV+avLylA2ngLEw6/IZtCkrg5wCiVL
 9Iw1TCi1w+/q1YC3wcdMcsIgLUOFStlFqot49EcaYXm/jfkzWeLPh9AVC/zlVySNHTgbREW
 BUnUE3FyRzbiIYcuQPeSw5WwGhKGwpfRnY4GX5ZlgvfBtX/m6B/R5mWc+jXnZi0B4k0ZfbA
 wsTUv4hw3U52n5VOra3/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:dxYrH9T57io=:s8Eg66AN9Rb9Y+IIoyVeCb
 fH6DSEoAmNDwpas52ag2gvNTwGs4WSX+59+VZ3ZTs/50lirXRVi2AIs69pUMXOecH2uOmOocw
 q/OJAJqoftDGfGYizP0ZbBPNftOYScN1BsBf+hAMkF4MPkBzYaKYJxdZzZ+C0j54UDVc5PAfv
 oSlv6pTXFD5TX5HdbK3QyJ7FkuuQyUjwB818DNElxuZxmHmt4cwWnuSc5rKvMGqzdqY2yLXLt
 x0dzN2kgE7Zv7aIBGJQwdfmnYiR2CPUoTfjS3XFz4OiKKhDLTo79hvz7RWvDnCSW9mEffpBtr
 Mo4N1lmSdWxEPijnIuvGbDZTULSDUk26AdI/hQ0q39ubeifbHP4Du8TBxvRtQPWDTmVwCjnEa
 8tqVUJXLgQG0Is8rQDSlDTxAy+Eu4yPqiz69XUt5ehvPTqZAKEjNFvN6jGEYfIuvIbb3mmtnA
 E4jqE0gz0tRnLvEuWwTKWlJlLLcIRKudWFIgtJ1j5pA/10yfuzzqYQXlo+gJ566cXTKWVzyyx
 8tmcgoaprQMkJDu4GfWKqstWIlXQfPTE9+cRaTRsgNY5ZGbpHLmFWPs8mEun1wXMyPNAiAGo/
 sOb+NKnNtOSpdAA++BLJlq2LD42Rfta5TfA1xs9wYX+WRnaFlR33IwLujkwR2Ti3vZFOhSPAg
 pRPY0lspmQoK18YM+ESokIc0KD+3Nosvc4Te0r0F+alsKoWCaydICO5RlyThoKlFFXo7Rncrc
 ZEK8BmhSNQsgczHLP1I4abkeBYFp/k9FoKfqo7+csX7MIlRvRotkiuvZgsqonfkNB9x+noX9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293547>

Hi Chris,

On Wed, 4 May 2016, Christian Couder wrote:

> On Wed, May 4, 2016 at 1:05 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> 
> > So... why not just say "bisect--helper: prepare for modes other than
> > 'next-all'"?
> 
> For (an extreme) example, in my patch series about libifying "git apply"
> functionality, should many of the patches have subjects like
> "builtin/apply: prepare for an apply.{c,h} lib"?

You are deliberately misunderstanding me.

If your patch series contained *one* patch whose intent was to prepare for
a libified 'apply', yes, indeed, I would think that it would make for a
fine commit subject. Especially if the other patches tried to do
completely unrelated things. Then your "low-level" change would really
benefit from a "high-level" commit message: the "low-level" aspect is seen
easily enough in the patch itself, thankyouverymuch.

It really misrepresents my comment to pretend that I had tried to
suggest something as utterly confusing as identically repeated commit
subjects.

Ciao,
Johannes
