From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Automatically remote prune
Date: Thu, 5 Nov 2009 08:45:41 +0530
Message-ID: <2e24e5b90911041915o40922167ob48a8503ee262b37@mail.gmail.com>
References: <43d8ce650911040242l44bbf87dm35494e04ce9039aa@mail.gmail.com>
	 <7v639qi2un.fsf@alter.siamese.dyndns.org>
	 <43d8ce650911041741w4b39d137ha2a1529a15256d27@mail.gmail.com>
	 <7viqdpemki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 04:15:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5spA-0003pn-Re
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 04:15:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZKEDPi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 22:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbZKEDPh
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 22:15:37 -0500
Received: from mail-iw0-f180.google.com ([209.85.223.180]:47613 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZKEDPh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 22:15:37 -0500
Received: by iwn10 with SMTP id 10so5498972iwn.4
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 19:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VfBlPopiXVUExF6uZwQCjkEch90XQmyZlKfN20bJEGk=;
        b=bh6RRHmhZGQC4FL/jKi4HaEmBfeLWNMkubO7zjeuOzlTdyn0iXxJKSKyXyfcS8hDf3
         k4I9eI6z7JhwXMP6MSiyhNu3SHX/ZvQbV/0WgBQhWgy4dU67Vv+LIGyAdoakDeVU0RhB
         Ky3g5ywnkt303+8qgodnY9X1/pa5Q2SwSk938=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SHBZfFAO0OcvGIPuUBxktB0HCJBSnoJaYmPBR1WUCPZYmMpDIr1HsF3jDmh+q+8LRc
         dEhIdSpzu2KMCjMpaDrYfnO59ovXcQl9Rs2W3SzT0CxeMu5MhPdkpllfGCOTjNgOzVJH
         BLoAtxX/lFaYijyKAzdpzHjRzBXLEP3QIsI8s=
Received: by 10.231.170.201 with SMTP id e9mr162907ibz.16.1257390942056; Wed, 
	04 Nov 2009 19:15:42 -0800 (PST)
In-Reply-To: <7viqdpemki.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132194>

On Thu, Nov 5, 2009 at 7:53 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:

> =C2=A0(1) The user wants to keep the remotes/<origin>/* namespace cle=
an (iow,

[snip]

> =C2=A0(2) The user does want to be careful not to lose commits that n=
ow only

This whole discussion is a conflict between those two.  The current
system does the latter, safer, thing.  John's users are getting
confused because they *think* this means the remote still has those
refs.

At best an alias that does a prune before (or after) a fetch should do.

And I notice 'git gui' has an option to "prune during fetch" -- maybe
that should be an option that is also made available to the CLI fetch.
