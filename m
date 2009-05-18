From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: Merging a branch when I don't want conflicts
Date: Tue, 19 May 2009 09:23:54 +0930
Message-ID: <93c3eada0905181653r2694550djd2e0f75de22c156d@mail.gmail.com>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>
	 <4A10FDC6.2040706@viscovery.net>
	 <93c3eada0905180105n641614eodb0469dceca20bc9@mail.gmail.com>
	 <4A112404.6060004@viscovery.net>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 19 01:54:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6Ceg-00062V-Eg
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 01:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbZERXxy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 18 May 2009 19:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZERXxy
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 19:53:54 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:24177 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbZERXxx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 19:53:53 -0400
Received: by qw-out-2122.google.com with SMTP id 5so2757601qwd.37
        for <git@vger.kernel.org>; Mon, 18 May 2009 16:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MDAtV2gQW++4OWq4t2PggAea5gP1ALUPKON4vtDGE3U=;
        b=q0BNWx6NdUxdsKH24Kki1OTHxLO4wwDRGwjTouBDpF35+nJNB5j1rRjIA4Ige2bbeX
         Zop8p+PPc10iYUxkrK9B0xQqXQjUVseJUPZ0QHcD320nP93LMbDocvKgorB309xw4ef8
         6OuFr4dyoCByJ5/SULUBn3fbO/mfoL1mQUCS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=pGNHyqDWKGwqL+w3JGYGsW6xT0WAU9Npugi7M3XpFZ5pXv4oQ0zUrWYQsWLOXtmQFJ
         ndKPVJfr+kVAfCKpSvAmVC8UipJAdZIUlds0BTtRuk+avJvemzSbQ1TsBzZiydJl4rMk
         SGZuvFuQyy+qIoMXhws4UeftqgnyixT8Kd518=
Received: by 10.220.90.144 with SMTP id i16mr7569851vcm.14.1242690834184; Mon, 
	18 May 2009 16:53:54 -0700 (PDT)
In-Reply-To: <4A112404.6060004@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119480>

On Mon, May 18, 2009 at 6:31 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Geoff Russell schrieb:
>> The file is data coming out of an interactive program which reads
>> the entire file, edits and then writes the entire file at which poin=
t
>> this file is correct
>> and all previous versions are obsolete. =A0I don't really want a mer=
ge
>> at all, but just
>> want to replace the file in the master with the version on the branc=
h.
>
> Ah, so finally you say what you mean ;)
>
> You can define a custom merge driver that always returns the content =
of
> the second branch. See 'man gitattributes'.
>
> -- Hannes
>

Sorry for the confusion. A custom merge driver will work fine ... but I
will also rethink carefully  what I am doing.

Cheers,
Geoff.
