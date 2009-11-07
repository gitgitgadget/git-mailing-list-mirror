From: Dilip M <dilipm79@gmail.com>
Subject: Re: Preserving branches after merging on ancestor
Date: Sat, 7 Nov 2009 09:11:11 +0530
Message-ID: <c94f8e120911061941l1fb62d84g9a5ba3f1a00d9156@mail.gmail.com>
References: <26217077.post@talk.nabble.com> <20091105223004.GA3224@progeny.tock> 
	<20091105232848.GA1939@atjola.homenet> <20091106010947.GB4425@progeny.tock> 
	<20091106021038.GA27206@atjola.homenet> <20091106050353.GA8824@progeny.tock> 
	<1257520877359-3959325.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: rhlee <richard@webdezign.co.uk>
X-From: git-owner@vger.kernel.org Sat Nov 07 04:42:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6cCP-0003sO-J7
	for gcvg-git-2@lo.gmane.org; Sat, 07 Nov 2009 04:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760075AbZKGDl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Nov 2009 22:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760069AbZKGDl0
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 22:41:26 -0500
Received: from mail-pw0-f42.google.com ([209.85.160.42]:44037 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760023AbZKGDlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2009 22:41:25 -0500
Received: by pwj9 with SMTP id 9so989405pwj.21
        for <git@vger.kernel.org>; Fri, 06 Nov 2009 19:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=c+6jDNobvmPO+STP8GNUxFvX3m+cmXaLTtpXRPkoqFs=;
        b=MzydiNuaZI7QsSDT5R8GlUvMrY6H/zB39+B48X/2jqoCoFrG8wQPeIKReMoaTFB8/h
         eaXpKnXB/1Q2K932pNvsAOKu1PPM7lFALBoAYY2kjW8INUj1KEHe04Z6eOqAl4FZyMX7
         Ys4zh/EKs0VxUIeNNciL9h1tzA9yWPEORbnjE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tL9WdX8sHf9T4nWjYuYWQX0b1Hzzu488oANah3CPVyuuN3SmQZv/55qmNXK74GEBlq
         VvJmoB5gxeWyaIpOmM3XCSBieAfOmH4DqOIwtgkvaevEd8nFUimxLIsgkDUfBicNxp6w
         ES0koNOdZ4JQMfAsv4EQHFJw9NyYemplta9u8=
Received: by 10.141.19.11 with SMTP id w11mr298565rvi.66.1257565291072; Fri, 
	06 Nov 2009 19:41:31 -0800 (PST)
In-Reply-To: <1257520877359-3959325.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132353>

On Fri, Nov 6, 2009 at 8:51 PM, rhlee <richard@webdezign.co.uk> wrote:

> Hi John, Bj=F6rn and Eric,
>
> Thank you very much for your replies from which I gained a lot insigh=
t about
> git merging and different workflows.
>
> Yes, I have tried out --no-ff and it does the job for me. (Incidental=
ly, doing
> that take it look neater in git gui as all the master nodes appear on=
 top of
> each other. Using empty commits, the merged branches appear on top th=
e master
> nodes in the graph.)

Thanks to Richard, John, Bj=F6rn, and Eric.

I had a similar _confusion_ looking looking at graph. I always use "log=
 --graph
--pretty=3Doneline". Now I have _opted_ to pull/merge with '--no-ff', t=
o keep the
graph plain and simple for non-power users :)



-- Dilip
