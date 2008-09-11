From: "Eric Raible" <raible@gmail.com>
Subject: Re: RFC: perhaps a "new file" should not be deleted by "git reset --hard"
Date: Thu, 11 Sep 2008 15:19:25 -0700
Message-ID: <279b37b20809111519o76bea81br738983b4cda1978e@mail.gmail.com>
References: <279b37b20809101212g57e9ad99qbf6fa15888679894@mail.gmail.com>
	 <eafc0afe0809101912v72916d3hce9ae5d6812f0db8@mail.gmail.com>
	 <eafc0afe0809101914lff5b23ehaf625d702fbd9b5d@mail.gmail.com>
	 <51419b2c0809101938v30e5a1aflf944027aedc2d900@mail.gmail.com>
	 <loom.20080911T204256-821@post.gmane.org>
	 <7vd4jas6x8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 00:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KduWh-0001PE-5Y
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 00:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbYIKWT2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 18:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbYIKWT1
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 18:19:27 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:34624 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYIKWT1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 18:19:27 -0400
Received: by py-out-1112.google.com with SMTP id p76so444947pyb.10
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 15:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=Mh3pDJMzr/y6x5REhfqUWYvfl7/IijjUZ4t+bvlmN3g=;
        b=ogawmA2NqKxtdsLxTQEzr9I7nkzXEDWj1gQg22Y4VxQmFD2/HNz5vKaJ5NReP/VRO3
         LVcGKF3LNN6nU9gY6lARQDzn07878dz+Un7Y/NtEBbbnyxq+qKY1XvjxTHNtbvBeCS4W
         j6zUyyeCTM4Zl12pXqBedg3Zj0BruByESHKEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ukdGQhqvn5gOeV9S0NRrD5MHZmcQJjZ6Pf8JoHmyzYyGCimzoB4LI92cnO0cVRfmQC
         H6McdS69jLAhF536vctAOIl/KlybGa2pS1xtKiTH33i8Dl/jooSPpAesFCsivm/N+FTh
         Dk1obLDVprivuZuCxlkNxFnqjivwkA5cIRoNk=
Received: by 10.142.211.1 with SMTP id j1mr780225wfg.313.1221171565723;
        Thu, 11 Sep 2008 15:19:25 -0700 (PDT)
Received: by 10.142.14.12 with HTTP; Thu, 11 Sep 2008 15:19:25 -0700 (PDT)
In-Reply-To: <7vd4jas6x8.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95656>

On Thu, Sep 11, 2008 at 2:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Raible <raible@gmail.com> writes:
>
>> But can you see a downside to "git reset --hard" treating newly
>> added files as "git reset"?
>
> Of course.  The --hard option is called --hard without inviting short
> option for a reason.
>
> [various good reasons snipped]

Thanks for the definitive response.  I suppose that I had been getting
rather cavalier about --hard.  Now my expectations are more aligned with
reality.

And that reality makes perfect sense, it's just a bit harsh when hundreds
of important files get obliterated!

- Eric
