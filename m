From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Checking for a valid email address
Date: Fri, 27 Feb 2009 10:20:02 -0600
Message-ID: <799406d60902270820r7edb16b2rab39ea7fd38a43c1@mail.gmail.com>
References: <799406d60902261928q2c691112yf24d01b92a3dad6c@mail.gmail.com>
	 <9b18b3110902270120t15babbc0oe2975c086297e1e0@mail.gmail.com>
	 <9b18b3110902270125p76ac118ckd21cb2d427940db2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 17:21:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld5T5-0003rE-7U
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 17:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835AbZB0QUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 11:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753861AbZB0QUH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 11:20:07 -0500
Received: from an-out-0708.google.com ([209.85.132.250]:43947 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbZB0QUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 11:20:06 -0500
Received: by an-out-0708.google.com with SMTP id c2so917195anc.1
        for <git@vger.kernel.org>; Fri, 27 Feb 2009 08:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/ZbR5JHtrMW2/6vKkBIZvTLjV6bAEE5l8PW4UFCDzw4=;
        b=dD9cw4XXG3mwr6NM7xaJTISyeiLwmGGF7VuccIhoui82o7AJq6RQKbLw9nNLGpHaPr
         fGq/GSDoHqIlyuVf+iNjyGOEZnTiUqSgcMyJZ2kMFa8LxMh+LzRZr1zy+ozOu7O9rofO
         hDqqU3M/5UHjEJ65PcwM2AhAAruGyYmAGBvtM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NM0mOWNzmkPWa1a93ix+JMJ/bJHfoyZ5Zy7sexgr6R4Mv9IRRJ8E5IN9AuaOZTPv1g
         04ZNziT5nqfj+/WN7/w4PDlVSzFjMu8HYxT6fk12LARORUNmoFF0wWkO5XqDe5tOe23i
         X+hxH/WskVp2ERps+rzuh6BPbROC/WC4O3L7g=
Received: by 10.100.242.20 with SMTP id p20mr2785690anh.83.1235751602510; Fri, 
	27 Feb 2009 08:20:02 -0800 (PST)
In-Reply-To: <9b18b3110902270125p76ac118ckd21cb2d427940db2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111681>

On Fri, Feb 27, 2009 at 03:25, demerphq <demerphq@gmail.com> wrote:

>> If you are using Perl 5.10 or later then you can use the following regex:

<snip>

>> which is a fully RFC compliant perl regex for validating any email address.
>
> Er, i meant validating whether any email address is well formed of course.

Thanks, that should be enough...

Cheers

Adam
