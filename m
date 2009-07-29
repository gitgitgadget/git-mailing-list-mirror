From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Adding files to a git-archive when it is generated, and whats the 
	best way to find out what branch a commit is on?
Date: Wed, 29 Jul 2009 04:40:19 -0400
Message-ID: <32541b130907290140y25c6a0b2r5ed0123e0ce1ae1@mail.gmail.com>
References: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:40:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW4iX-0007mW-GH
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 10:40:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638AbZG2Ikk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 04:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752607AbZG2Ikj
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 04:40:39 -0400
Received: from mail-yx0-f190.google.com ([209.85.210.190]:52046 "EHLO
	mail-yx0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019AbZG2Ikj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 04:40:39 -0400
Received: by yxe28 with SMTP id 28so1097153yxe.33
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=mGlMpsgrs8iQ04HrRmxgZubYCIzv7sN1Ok9MzTwKxXs=;
        b=wzivcRDZtXRH5SOQC+6D0/BZl8tHUbHvRH6zpI3MypZm2XTbK8evkyiJpSWK9IukZr
         hnXgJRua5p1drweG1VRmbjHOxpGGBIQ3O+o6NNT0P/8f1ovmTfN3YaFkIWlHmXDQsN4m
         yG+QA4ibDMwYClvOrS89CrplKYn9HOD3Ek3uc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KJydqvRNoRuTR8IBTdz0kZf+s3IWJnStclU3TUUYeiBEt9tzP8J77mpdcX3oJ8epyr
         Y9ykhkri4yXUtqP/i8IqNSPq+8RCIolZonMRCe9q+5P/kSBhYwQOfwCw1lfWfsHz4ItO
         mL3SKHX85pUUj2whZ3m9Xi9xmmYv727EyhGZA=
Received: by 10.151.44.16 with SMTP id w16mr1004976ybj.248.1248856839096; Wed, 
	29 Jul 2009 01:40:39 -0700 (PDT)
In-Reply-To: <9b18b3110907290115v1f30eeat748631bb09f92517@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124326>

On Wed, Jul 29, 2009 at 4:15 AM, demerphq<demerphq@gmail.com> wrote:
> Another question is whether anyone has any advice on the best way to
> find out the "best" branch an arbitrary commit is on. Where best can
> be flexibly definied to handle commits that are reachable from
> multiple branches. =A0I have hacked a solution involving git-log and
> grep, but it performs quite poorly. I was wondering if there is a
> better solution.

'git describe' does this.

Avery
