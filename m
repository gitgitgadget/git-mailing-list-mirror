From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: setting up tracking on push
Date: Tue, 24 Mar 2009 02:58:06 -0700 (PDT)
Message-ID: <m3ocvr2qfx.fsf@localhost.localdomain>
References: <49b12ff7.nCWIz4ABJcgwW3BZ%obrien654j@gmail.com>
	<87d4cuobrc.fsf@catnip.gol.com> <49B6CCDB.8010305@xiplink.com>
	<20090310230939.GB14083@sigio.peff.net>
	<76718490903101852y2c90e0abi8e0e4f71e6f0bc52@mail.gmail.com>
	<20090311020409.GA31365@coredump.intra.peff.net>
	<76718490903101959i61df26aagdff44bb9ab4593ab@mail.gmail.com>
	<20090311030604.GA3044@coredump.intra.peff.net>
	<76718490903102044j4ca3462eye5ffcb178608dc29@mail.gmail.com>
	<20090311035701.GA6089@coredump.intra.peff.net>
	<76718490903102115x27a869f2la0d5ca9003bcc95a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Marc Branchaud <marcnarc@xiplink.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 10:59:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm3Q6-0006KG-LU
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 10:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755233AbZCXJ6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 05:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbZCXJ6L
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 05:58:11 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:58090 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553AbZCXJ6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 05:58:10 -0400
Received: by qw-out-2122.google.com with SMTP id 8so2110639qwh.37
        for <git@vger.kernel.org>; Tue, 24 Mar 2009 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZzqOT0+WJizUVGjreJxerWhS7zKyD7vcJQzNLrJWavg=;
        b=igjvxjlRUkjgADRK+y49+pRCArkMsLKSrbjlg4sKtxzp24iz4LjgLT8Ql0Q7QpXelR
         gYmio2xnjGxHc2Xz5JNPRYfmBFXVtv2V6VmPRQi9s3rN0O5upR/YDUHg90IbAjTENZhs
         re0fdgd4/6UZQeXiUML/vle+YvEPphB3OVJkk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iat29Otj29WHj3xiaUhSwtcO+TyionAsgMGWOmVLTZ0WvhpWRTdPUNx2Aes9e5GENp
         G3cY00K0R2iDlVX/O3D0Qjil9x9V5fUWzAsZMJB1qc/zO+VOOHypHDKmHUcptuoA82T8
         PsPeuz4QA2QBhkSNZMBoCbikVmOJmW8YDNrBs=
Received: by 10.224.67.75 with SMTP id q11mr10326421qai.272.1237888687657;
        Tue, 24 Mar 2009 02:58:07 -0700 (PDT)
Received: from localhost.localdomain (abvk67.neoplus.adsl.tpnet.pl [83.8.208.67])
        by mx.google.com with ESMTPS id 5sm5579873qwh.29.2009.03.24.02.58.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Mar 2009 02:58:06 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n2O9vxHE002001;
	Tue, 24 Mar 2009 10:58:00 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n2O9vs1S001998;
	Tue, 24 Mar 2009 10:57:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <76718490903102115x27a869f2la0d5ca9003bcc95a@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114444>

Jay Soffian <jaysoffian@gmail.com> writes:
> On Tue, Mar 10, 2009 at 11:57 PM, Jeff King <peff@peff.net> wrote:

>>> -u w/o --track/--no-track is a usage error.
>>
>> Then what is the point of "-u"? You said before that it was a new
>> operation with room for future growth of additional options. Either it
>> is _just_ for --track, in which case I think you are better to have a
>> single option representing the notion of "update the tracking setup", or
>> it isn't, in which case it needs to have room for future expansion.
> 
> For *now*, it is just for --track/--no-track, since I can't think of
> anything sensible that "-u" without --track nor --no-track would do.
> 
> So it means, update the branch config, but you have to tell it what
> aspect of the branch config to update.
> 
> I agree that currently, a single option could do here, but I can't
> think of a good one. --add-tracking and --delete-tracking? I was
> trying to re-use the fact that we already have --track and --no-track,
> but I needed some way to differentiate the mode from "create a new
> branch". Hence -u.

I would suggest '-n' here, as "git branch" doesn't do its main
function (with a branch), namely create, delete or modify branch head.
Your '-u' is all about _not_ updating branch head, but peripheral
information.

But I do wonder if it is really a good idea...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
