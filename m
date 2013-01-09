From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: On --depth=funny value
Date: Wed, 09 Jan 2013 22:38:54 +0100
Message-ID: <50EDE36E.8030700@googlemail.com>
References: <1357632422-5686-1-git-send-email-stefanbeller@googlemail.com> <CACsJy8BLLTWd+cTBj1jNW=ODPy7=Kg4-TPUdZ82YCE-0RQpMZA@mail.gmail.com> <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 22:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt3Mr-0007Tg-MM
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 22:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933251Ab3AIVjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 16:39:01 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:52339 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933226Ab3AIVi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 16:38:59 -0500
Received: by mail-ee0-f41.google.com with SMTP id d41so1092051eek.28
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=0fPiBjFDtFE/OIHjCifqccrIU0dxUu+pDAfGjtnPBuw=;
        b=LCFS9YPj/68W0NO2Wjgl/wjjK/G6WVAHXvdq0jHJLWmfj707tbhVXGpMUTRIXggNib
         GogN/s7B1iWkaZUuPR2yGYqdHP5b/7mkhjMZTJMs09a2HAnwX57gm/npjq+Df7zES9lE
         bhlfilEX17lyEQssECp7empiMZXn6iao2rvf2MDlr9qa/VhLemQWiXl8NShRIRUUjSJZ
         qPclM3COdEj0kD5sR9Kw7PrhQN9aayxFB7tnBhn1HLO5zjYfj65kwkVv1uC7/VFcQ5e7
         I66staw7IymSstGmIYm0dpew+IxE4ZNpEj8Z0TgHCiaagm9NSlwXu2qoAdVFj9JGRDYm
         o3zg==
X-Received: by 10.14.181.135 with SMTP id l7mr74306020eem.19.1357767537724;
        Wed, 09 Jan 2013 13:38:57 -0800 (PST)
Received: from [192.168.1.3] (ip-109-91-111-92.unitymediagroup.de. [109.91.111.92])
        by mx.google.com with ESMTPS id k4sm143917988eep.15.2013.01.09.13.38.54
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Jan 2013 13:38:55 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <7vy5g383sy.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213106>

On 01/09/2013 03:53 AM, Junio C Hamano wrote:
> Can people sanity check the reasoning outlined here?  Anything I
> missed?
> 
> The above outline identifies three concrete tasks that different
> people can tackle more or less independently, each with updated
> code, documentation and test:
> 
>  1. "git fetch --unshallow" that gives a pretty surface on Duy's
>     "--depth=inf";
> 
>  2. Making "git fetch" and "git clone" die on "--depth=0" or
>     "--depth=-4";
> 
>  3 Updating "upload-pack" to count correctly.
> 
> I'll refrain from saying "Any takers?" for now.

Sorry for answering with delay, I am just contributing to git in my
spare time.
So if I understood Duy correctly, he is going to solve 1. and 3 by his
patches.
I'll try to come up with a solution for 2. within the next days.
