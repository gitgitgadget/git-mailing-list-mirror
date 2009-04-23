From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [doc] User Manual Suggestion
Date: Thu, 23 Apr 2009 13:37:05 -0500
Message-ID: <b4087cc50904231137g67b4b84eu3b61bf174ba37d7f@mail.gmail.com>
References: <m24owgqy0j.fsf@boostpro.com> <20090423175717.GA30198@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:39:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3pi-0002qq-JE
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 20:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758113AbZDWShK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 14:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758281AbZDWShJ
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 14:37:09 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:47942 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754436AbZDWShG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 14:37:06 -0400
Received: by qyk16 with SMTP id 16so1412924qyk.33
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rnWxIeFS5Y3f+apWGUzXddazVNsSmhlKkdNDoPnW8Rc=;
        b=scOsFPQ3oEJr1nbAB9xDW5nBhcWnlOSwqM+KucuiR/94dexspFEApt2kE1br2yaflf
         /nY46oBD6/qsTETwujOsPlC1mnKBmS1oQxwz2bKM0fu0bv14mjUFCzXIMKUdV8s4i4ho
         JeIpywnEHn+tnRGDEnNOLPR6gD1XMt8zrYVrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m19S69xBOzcYcvjsoW1B0LEQefCZaTCSw12b13cf5w/CeB8B++Ss9v9y+4R8ixvfDW
         K9vVswNbhRPkSH0OG/tnxfgGUmU9rSmf0csZJRX2DN5RfvMamlG3KsDV/5nuMIaK6lG/
         WxUlDdk1yytnrKttq3YDcxjvk9wlfV6LPCcSM=
Received: by 10.224.11.77 with SMTP id s13mr1801975qas.4.1240511825975; Thu, 
	23 Apr 2009 11:37:05 -0700 (PDT)
In-Reply-To: <20090423175717.GA30198@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117361>

On Thu, Apr 23, 2009 at 12:57, J. Bruce Fields <bfields@fieldses.org> w=
rote:
> On Wed, Apr 22, 2009 at 03:38:52PM -0400, David Abrahams wrote:
>>
>> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#how=
-to-check-out
>> covers "git reset" way too early, IMO, before one has the conceptual
>> foundation necessary to understand what it means to "modify the curr=
ent
>> branch to point at v2.6.17". =A0If this operation must be covered th=
is
>> early in the manual, it should probably not be until
>> http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#man=
ipulating-branches
>
> I agree; we should suggest just a git-checkout (to a detached HEAD)
> instead, though that needs a little explanation so people aren't scar=
ed
> by the warning message it gives.

Everyone talks about "before one has the conceptual foundation
necessary to understand". Well, here's an idea: The git documentation
should start with the concepts!

Why don't the docs start out defining blobs and trees and the object
database and references into that database? The reason everything is
so confusing is that the understanding is brushed under the tutorial
rug. People need to learn how to think before they can effectively
learn to start doing.
