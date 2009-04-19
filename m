From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH RFC3.5 05/12] send-email: Improve redability and 
	error-handling in send_message's sendmail code
Date: Sun, 19 Apr 2009 10:16:27 -0400
Message-ID: <76718490904190716u155f7f78ve78bfa61d3d1d468@mail.gmail.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240074128-16132-6-git-send-email-mfwitten@gmail.com>
	 <76718490904181851g2701ce59x614ea60452b914ce@mail.gmail.com>
	 <b4087cc50904181913g117937le333c3b255f7d184@mail.gmail.com>
	 <18071eea0904181917u7c7187bubc8fab6ede2d19ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 16:18:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvXqO-00011q-6q
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 16:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959AbZDSOQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Apr 2009 10:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757490AbZDSOQa
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 10:16:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:63346 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755012AbZDSOQ3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Apr 2009 10:16:29 -0400
Received: by yx-out-2324.google.com with SMTP id 3so539773yxj.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 07:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7xS0vZAZd5qhc5SEjNBcnDZs7KVfADFCHZwC9DLc0q8=;
        b=cvDGX1Qhf0ulTBimt1UkQueJ36+FPQD4YfRXktxxjYBLke1Pui88bI211q3R87coUA
         zk6RStbnZDvNG0TV1uKUhML7wySy5I7MxZXeQ1XKh+hsRIpkX+5bz2M0MdifT2c3dNHy
         P5dprvwcbMl3HIpb6NtuLmM1Gd9EhElQHG5Ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tTBadz74dfMOjSW3SB9mJYw3VylyKZeex63bSuadQyXnhIkbx0jcejXUHHBYe9JxLx
         Hkx0KwbkMnXR5ZctDLFQECveLLyo57IbgqfFPZ7TLrHkPmPbhwNXyK6VHBaezVC6y4Df
         ZOrEsSh27WcIgzaGQ30CL/TW1uPWZs5ftPnJU=
Received: by 10.151.15.20 with SMTP id s20mr4338971ybi.233.1240150587927; Sun, 
	19 Apr 2009 07:16:27 -0700 (PDT)
In-Reply-To: <18071eea0904181917u7c7187bubc8fab6ede2d19ef@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116897>

On Sat, Apr 18, 2009 at 10:17 PM, Thomas Adam <thomas.adam22@gmail.com>=
 wrote:
> 2009/4/19 Michael Witten <mfwitten@gmail.com>:
>> However, I wonder if your comment is a veiled quip at my "Improve
>> redability" claim (which is also ironically unreadable). :-)
>
> More concerning is that it's a perl 5.10ism -- you cannot assume that
> perl 5.10 is installed on all platforms. =C2=A0I really wouldn't use =
this
> construct.

Exactly. I started with perl4 (no really...), then moved away from
hard-core perl coding around 2000 and have been just a perl dabbler
since then. So I didn't recognize //, though I suspected it was a
newer construct. :-)

j.
