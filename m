From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 04/23] http-push: send out fetch requests on queue
Date: Sat, 6 Jun 2009 09:14:22 +0800
Message-ID: <be6fef0d0906051814v5fd82b9ds7a6d735603491326@mail.gmail.com>
References: <20090606000137.ff05ba37.rctay89@gmail.com>
	 <m3r5xy5s1n.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 03:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCkUP-00070P-Mb
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 03:14:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbZFFBOW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 21:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753349AbZFFBOV
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 21:14:21 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:59638 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbZFFBOU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Jun 2009 21:14:20 -0400
Received: by wf-out-1314.google.com with SMTP id 26so826062wfd.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 18:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZoU8RqTeUsmPOK7CrsyYnZ3ct3o7E1D0dciYPx4uEhc=;
        b=DyMTBTgRKR4SAvoHBB6sG4cpKQi9M84asJiqqB6XsFBJgVPCFdqq+aQP47yMGt6mIs
         7N5W2bgG+8Sjcm2yg/eS1ZOugpM7M3p75mbEyiJxCSLiVLjYCbE6EDF+9AQBh/VIfcPu
         9fOvG25Lgomq6ytGuS3ViMEbUhAQpF09W2TZc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ANAEjJf6dYDAculLPuzwMOufgYvkDXyiEG1TWi37KiNCFGGWRzFp8cjEYWjzkDVFn1
         vqNR+kcaVWxkeEC5mJvySnzN6uFb3n6auw7Nq6ky7HZPsS7n/yFNhCy4uLkLTJSpkIGt
         dd0APmjKNPbK2auSZop1rE43TfIoRNCCK4ggg=
Received: by 10.142.188.12 with SMTP id l12mr334817wff.124.1244250862388; Fri, 
	05 Jun 2009 18:14:22 -0700 (PDT)
In-Reply-To: <m3r5xy5s1n.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120859>

Hi,

On Sat, Jun 6, 2009 at 4:44 AM, Jakub Narebski<jnareb@gmail.com> wrote:
>> Previously, requests for remote files were simply added to the queue
>> (pointed to by request_queue_head) and no transfer actually took
>> place[1], even though code that followed may rely on these remote fi=
les
> =A0 =A0 =A0 ^^^
> =A0 =A0 =A0 ^^^--- you have footnote reference, but no footnote

Thanks for catching this.

--=20
Cheers,
Ray Chuan
