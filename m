From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 03:22:56 -0500
Message-ID: <20120417082256.GA20240@burratino>
References: <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <7v7gxftn78.fsf@alter.siamese.dyndns.org>
 <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
 <20120416224411.GU12613@burratino>
 <CAMP44s0cdSaiCoMLk7oTHE4dies5-G0C7-RczK5OFEK=pYUW_A@mail.gmail.com>
 <20120416231626.GW12613@burratino>
 <CAMP44s3OSepH_XpCcTWLN=bF0+P9fmHtyPnWdQnEocW25jHTpA@mail.gmail.com>
 <20120417073653.GB20017@burratino>
 <CAMP44s3mnnhKXHUEMSX+d2L2Jyqr9_Q7F=3DvWb4MKxHpTRREg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 10:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SK3gw-0004m1-EG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 10:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755306Ab2DQIXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Apr 2012 04:23:07 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35625 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab2DQIXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2012 04:23:05 -0400
Received: by iagz16 with SMTP id z16so8622812iag.19
        for <git@vger.kernel.org>; Tue, 17 Apr 2012 01:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+DnoCo21E2G8GFCz0rBCyl5M0UHiex/hQi7h5vV8mi0=;
        b=ewnLrrPbPn4g4nvgTrE4izgfLVBrEHknQuW64j7ce53doi7MuRE4bJn2+jOVvuLcFR
         DFgyk6GB5KJrim3kSMLBBw940duXpAXTQit0hcCCkSV9ADILdw52DQGfK2mDL7OZ6CTW
         kTlY30EnyTJFX552zV1npn1v1DBWI5FnlVjm8sCA9Vv4peLksPdwTeGOZYQytM7P7XMJ
         XOfGi53NfEighDd78yixzXK8hsGpS1EVg0ln2DzDlInY4Dc2GZiJGRoNq+sc+E7wWfAp
         28KhBzwwKLC4ZtZRmCnxU0NBmvAt+dHtSpTPibymjhIKiS7VS9B07RZ/pEGTD55aPC5w
         iVXQ==
Received: by 10.50.85.131 with SMTP id h3mr8285123igz.39.1334650984004;
        Tue, 17 Apr 2012 01:23:04 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id a10sm14520926igj.10.2012.04.17.01.23.03
        (version=SSLv3 cipher=OTHER);
        Tue, 17 Apr 2012 01:23:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s3mnnhKXHUEMSX+d2L2Jyqr9_Q7F=3DvWb4MKxHpTRREg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195744>

Felipe Contreras wrote:

> I took your argument seriously and looked for evidence myself, and in
> the absence of evidence I'm still not throwing it away, I'm assuming
> it has merit and added code to make sure we don't override some user
> function that has the same name. That would solve the problem you
> raised

Ah.  All that talking, but I was not addressing your actual point.

I though you didn't believe that the namespace adopted by the
bash_completion project was "identifiers starting with underscore,
plus a few old identifiers that have been grandfathered in".

But in fact, you just don't like namespace conventions.

Now I'm exhausted so I have no time to explain why a project that
involves implicitly including scripts from a wide variety of authors
into a flat namespace shared with others might end up using a
convention to manage that namespace.  But at least the world seems a
little saner.  Sorry for the wasted time.

Please, next time just say what you mean instead of leaving me talking
about something irrelevant.
