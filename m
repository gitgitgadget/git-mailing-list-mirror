From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Truly decentralised use of git?
Date: Tue, 14 Jul 2009 15:34:37 +0200
Message-ID: <81b0412b0907140634g6aeec60fib23d56d83ba09fb9@mail.gmail.com>
References: <200907140811.24174.Karlis.Repsons@gmail.com>
	 <adf1fd3d0907140222t6762d4f7s417f56905492cbba@mail.gmail.com>
	 <200907141323.02151.Karlis.Repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>,
	git@vger.kernel.org
To: =?UTF-8?Q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 15:34:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQi9f-0003GD-9Q
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 15:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbZGNNek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2009 09:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbZGNNej
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 09:34:39 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51763 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753002AbZGNNej convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Jul 2009 09:34:39 -0400
Received: by fxm18 with SMTP id 18so2813466fxm.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 06:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=hd7GjzDVWB4ApGZACQXcZ9prDTRWN1GCkBGJuUTJR78=;
        b=aHK5IPhHhQ96fQ8XGF+WPGitLL1KjXSytSzuf8Ugk5XBFK9McZxYG55e7KFNdR5TmT
         u34fAvRnkl2CjODU/yQkO7KSgv0gy3e+2wIrfsnhgYCDSeTmse79uF1cl1w1iXhef6dj
         F1Yk9rQkvb5T0NYrvU8On3BcprQ8L6O+2WDFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LHKKwqMSL1+q3M3VoQie84YiH16g72NlvJHYNd7V157+pj0QmFNXW9i3fXQUBND8HL
         T+fed8gBUJqPfVEAFjhtqN400I0GWUqgzcfwlvC64d7slEPiGqRYpPYeUm5skrYEAZ8H
         0aNCwVSsrDGH/RYz2IXFniox051iyteB7kY8Q=
Received: by 10.204.112.205 with SMTP id x13mr6369628bkp.213.1247578477710; 
	Tue, 14 Jul 2009 06:34:37 -0700 (PDT)
In-Reply-To: <200907141323.02151.Karlis.Repsons@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123246>

On Tue, Jul 14, 2009 at 15:22, K=C4=81rlis Repsons<karlis.repsons@gmail=
=2Ecom> wrote:
> I am sorry, another thing was of my interest.
> My unknown is the technical realisation - how can particular reposito=
ry be
> made available for easy pulling from it? Right now with IPv4 most nor=
mal
> workstations are not accessible directly, because they are behind rou=
ters.

Same as with the rest of all internet services: you either put the thin=
g on
an internet-facing address or poke a hole in your firewall.
