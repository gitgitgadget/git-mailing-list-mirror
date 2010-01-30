From: David Rhodes Clymer <david@zettazebra.com>
Subject: Re: Custom git completion
Date: Sat, 30 Jan 2010 18:03:43 -0500
Message-ID: <9b69cfcf1001301503n455191cdse93a7d4e86c0e6a0@mail.gmail.com>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	 <20100129151127.GA21821@spearce.org>
	 <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
	 <20100129175950.GE21821@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jan 31 00:03:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbMM1-0001PY-PO
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 00:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253Ab0A3XDp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 18:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148Ab0A3XDo
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 18:03:44 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:54586 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab0A3XDo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 18:03:44 -0500
Received: by pxi12 with SMTP id 12so2887318pxi.33
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 15:03:43 -0800 (PST)
Received: by 10.142.208.16 with SMTP id f16mr1764641wfg.158.1264892623152; 
	Sat, 30 Jan 2010 15:03:43 -0800 (PST)
In-Reply-To: <20100129175950.GE21821@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138516>

On Fri, Jan 29, 2010 at 12:59 PM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>>
>> How does the completion code learn what options and arguments such a=
liases
>> and subcommands (e.g. "git foo") take without being told?
>
> Sure. =A0But the patch offered by the original poster also suffered
> from this problem, it didn't know how to complete arguments for
> the subcommand.
>

My patch allows custom completion code to be called if available. I
don't expect git completion to know anything about my new command.

-davidc
