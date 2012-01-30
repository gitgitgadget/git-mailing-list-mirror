From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 4/4] completion: be nicer with zsh
Date: Mon, 30 Jan 2012 13:03:21 -0600
Message-ID: <20120130190321.GD22549@burratino>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-5-git-send-email-felipec@infradead.org>
 <20120130175324.GH10618@burratino>
 <CAMP44s0ACC+AnwHGtBLe8C1S_sxWj6SbMbawDThvLQAA0pKMYQ@mail.gmail.com>
 <20120130182547.GA22549@burratino>
 <CAMP44s1SzE1h+4Eoebr2LrnLNgFX1UE2+O8z6yYDuukmaijf7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipec@infradead.org>, git@vger.kernel.org,
	Lee Marlow <lee.marlow@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 20:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwVr-0007BA-1i
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab2A3TDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 14:03:30 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58843 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026Ab2A3TD3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 14:03:29 -0500
Received: by ghrr11 with SMTP id r11so1943669ghr.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 11:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XaRnUG9RO8DvxjuNh/UoIjSm7hJsMCH+2g+tfMIkMVA=;
        b=KiR2lXChdEz13lZ2CZf2qE0Hn+UYBQeeCdygPy1xCNjH0Y4ggxqjaKcZGOmvPEDz2s
         0B6b6iFU3iTHMQ7Ga/b8y5DOOKL6tTCppyWnquF+9v9eLcBAyHfwzIlLa8RSqmGFYKIw
         EXR+8RDcQxCCBwXOKomLB6B5zFkn5KEM9Lo58=
Received: by 10.101.1.3 with SMTP id d3mr8316877ani.84.1327950209114;
        Mon, 30 Jan 2012 11:03:29 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm48554726and.3.2012.01.30.11.03.27
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 11:03:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAMP44s1SzE1h+4Eoebr2LrnLNgFX1UE2+O8z6yYDuukmaijf7Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189398>

=46elipe Contreras wrote:
> On Mon, Jan 30, 2012 at 8:25 PM, Jonathan Nieder <jrnieder@gmail.com>=
 wrote:

>> : is a no-op command. =C2=A0It does not redirect stderr automaticall=
y or
>> do any other magical thing.
>
> Why don't you go ahead and try it?
>
> bash -c ': echo "err" > /dev/stderr'

: is a no-op command.  If you have any questions after reading about
it in your manual or online help system of choice, I'll be happy to
answer them.

[...]
> Maybe '[' then.

Honestly, I don't care. :)

(If I had to choose a convention for scripts specific to ksh-style
shells, in order of preference, I would rank them:

 1. Always use [[.
 2. Use "test", spelled out, like the portable shell code in git does.
 3. Use [.

If you have arguments for one convention or another that are
compelling enough that the codebase won't be flipping back and forth
and a patch to go along with them, I imagine no one will mind.)

By the way, since I forget to say enough: thanks for taking care about
this code.  Simpler code is definitely a good thing.

Regards,
Jonathan
