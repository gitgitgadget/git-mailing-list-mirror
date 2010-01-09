From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH (v2) 2/2] rebase -i: teach --onto A...B syntax
Date: Sat, 9 Jan 2010 16:02:09 -0500
Message-ID: <32541b131001091302t8d890d8ped85d6bd07f6cd66@mail.gmail.com>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org> <7vocl7yxef.fsf@alter.siamese.dyndns.org> 
	<20100107200509.6117@nanako3.lavabit.com> <7vtyux3bx1.fsf@alter.siamese.dyndns.org> 
	<32541b131001081216p27d7e29bu269755db895128@mail.gmail.com> 
	<fabb9a1e1001081222q7122872bu72cea4e393f272ac@mail.gmail.com> 
	<32541b131001081231x1b6ac8c1k30084e4abf8cc896@mail.gmail.com> 
	<fabb9a1e1001081237n11fa61b5m63fa46fac2ad8d4a@mail.gmail.com> 
	<4B47BE13.7070509@gmail.com> <alpine.DEB.1.00.1001090235520.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 09 22:02:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NTiSA-0007gQ-S0
	for gcvg-git-2@lo.gmane.org; Sat, 09 Jan 2010 22:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754Ab0AIVCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Jan 2010 16:02:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753561Ab0AIVCa
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Jan 2010 16:02:30 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47124 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab0AIVC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jan 2010 16:02:29 -0500
Received: by yxe17 with SMTP id 17so19412786yxe.33
        for <git@vger.kernel.org>; Sat, 09 Jan 2010 13:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=RiQR0sfVC99AkCEHTwltGHg1wJkfVhDZn9xOPk+UFss=;
        b=ZxvYuHKgdek54C/gLfPjU82Zv6JzjYZWI4tkIKPdQEQwiq1swh5Y5Y6KvXWSKJkkDX
         4BMmdhfRKKrJoMpDyRckCtGwK6XTRVyEl70YeX0fi6jGLWv9YsgrlKsd2SlEgmPZgAMt
         W0GwHVJz5udqsFYgRVBdBk/KULdCRDv7KssL4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dPLSlTLa6ryU5NI/IeODBGSrtEoQHUvlPTfb7lQGuILZZzNWipIvyuXopH85FqaRJz
         rw9f6vYzYzwFfXrt9l3OGhpnrvOsaJF+bEUKv9CQuWe6qV+LTNYRUsSruXgqxeME47N4
         r5PHzZxX1pH3SU8b2MQHSUhKqbYyprbKUJoBA=
Received: by 10.150.110.23 with SMTP id i23mr6075347ybc.345.1263070949083; 
	Sat, 09 Jan 2010 13:02:29 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001090235520.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136539>

On Fri, Jan 8, 2010 at 8:36 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 8 Jan 2010, A Large Angry SCM wrote:
>> Sverre Rabbelier wrote:
>> > *cough* git sequencer *cough*
>>
>> *cough* not in my ${PATH} *cough*
>
> *cough* because that GSoC project failed in all but writing? *cough*

Is there a summary of the results somewhere?  I can find a lot of
discussions of git-sequencer, but not what went right/wrong or if it
turned out to be a good/bad idea.

Avery
