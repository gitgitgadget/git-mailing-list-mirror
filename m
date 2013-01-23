From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 16:32:03 +0100
Message-ID: <87d2wvc3v0.fsf@pctrast.inf.ethz.ch>
References: <50D861EE.6020105@giref.ulaval.ca>
	<50D870A0.90205@interlinx.bc.ca> <50EC453A.2060306@giref.ulaval.ca>
	<50EDDF12.3080800@giref.ulaval.ca> <50F7F793.80507@giref.ulaval.ca>
	<CAGK7Mr4R=OwfWt4Kat75C8YDi3iLTavMLxeoLxkf1-gKhxrucg@mail.gmail.com>
	<50F8273E.5050803@giref.ulaval.ca>
	<871B6C10EBEFE342A772D1159D1320853A042AD7@umechphj.easf.csd.disa.mil>
	<50F829A9.7090606@calculquebec.ca>
	<871B6C10EBEFE342A772D1159D1320853A044B42@umechphj.easf.csd.disa.mil>
	<50F98B53.9080109@giref.ulaval.ca>
	<CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
	<87a9s2o6ri.fsf@pctrast.inf.ethz.ch> <kdk2ss$498$1@ger.gmane.org>
	<87r4lejpx8.fsf@pctrast.inf.ethz.ch>
	<50FF051D.5090804@giref.ulaval.ca>
	<878v7keuh3.fsf@pctrast.inf.ethz.ch>
	<CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Thomas Rast <trast@student.ethz.ch>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, <git@vger.kernel.org>,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 16:32:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty2JV-0000xT-RC
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 16:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492Ab3AWPcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 10:32:10 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:53376 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755280Ab3AWPcH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 10:32:07 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 23 Jan
 2013 16:32:02 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 cas10.d.ethz.ch (172.31.38.210) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 23 Jan 2013 16:32:04 +0100
In-Reply-To: <CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
	(Erik Faye-Lund's message of "Wed, 23 Jan 2013 16:23:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214327>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Tue, Jan 22, 2013 at 11:14 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca> writes:
>>
>> Other than that I agree with Junio, from what we've seen so far, Lustre
>> returns EINTR on all sorts of calls that simply aren't allowed to do so.
>
> I don't think this analysis is 100% accurate, POSIX allows error codes
> to be generated other than those defined. From
> http://pubs.opengroup.org/onlinepubs/009695399/functions/xsh_chap02_03.html:
>
> "Implementations may support additional errors not included in this
> list, *may generate errors included in this list under circumstances
> other than those described here*, or may contain extensions or
> limitations that prevent some errors from occurring."

That same page says, however:

  For functions under the Threads option for which [EINTR] is not listed
  as a possible error condition in this volume of IEEE Std 1003.1-2001,
  an implementation shall not return an error code of [EINTR].

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
