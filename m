From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 15:33:20 -0500
Message-ID: <20120416203320.GF12613@burratino>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
 <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:34:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJsdE-0005BU-7C
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737Ab2DPUdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:33:32 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50558 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755554Ab2DPUd3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:33:29 -0400
Received: by iagz16 with SMTP id z16so7902866iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 13:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=9gfub0IoO9/rrKiZT3xpReDf82Z24CO32L+L2C2LbuA=;
        b=NOVqyndu36I3cF/OsvH2ajHbkEjHzFLtgy84QoTttjJLiWdXGX0uarMrabfeQMS2eI
         xi5KQTN0aUskSkLWkEuOScOtVYeaf50Rrc1Jgoii4+towKQBrmBHeR+yHqNz0LudXyFv
         /RVOCpLyUSo5Cur+Gfapt0B3WWL+bCVFEJhgj24DFXPaBxSciJAnhie9sMgg1ctImlif
         NZa8cATPs3s/00yuE+gaEl7r5U97HKwFHbq/X2yppEonmmthaZu8zVKI+REu4JgpRMfg
         fDXSEtkXG4TjufEmFmPPQemreB/lVSaMSSWMH5bbmu/S8o5Z+hgTT8Iqias2pyPJ7vGr
         hCRA==
Received: by 10.50.184.166 with SMTP id ev6mr7226137igc.63.1334608408935;
        Mon, 16 Apr 2012 13:33:28 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i6sm27843436igq.3.2012.04.16.13.33.27
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 13:33:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195689>

Felipe Contreras wrote:
> On Mon, Apr 16, 2012 at 11:09 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> Felipe Contreras wrote:

>>> I would like to see a completion script that actually has a function
>>> supposed to be exported and that still uses the _ prefix anyway.
>>
>> The /etc/bash_completion library itself exports lots and lots of
>> functions with a _ prefix.
>
> We are not making a bash_completion library; I mean a bash completion
> script (other than the library).

Ok.  If you refuse to put two and two together, then I will (as usual
when this happens) just be a little passive aggressive and annoyed and
let you talk to other people.

Cheers,
Jonathan
