From: Alex Scarborough <alexsc@garagegames.com>
Subject: Re: [PATCH] git init: optionally allow a directory argument
Date: Fri, 24 Jul 2009 23:41:59 -0700
Message-ID: <EA5BDEF8-BACD-49FD-8AE9-D76D87DCFA40@garagegames.com>
References: <20090725065928.6117@nanako3.lavabit.com> <7vab2t64cg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 08:42:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUaxQ-0001jB-5t
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 08:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbZGYGmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 02:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755141AbZGYGmD
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 02:42:03 -0400
Received: from mail-px0-f184.google.com ([209.85.216.184]:58502 "EHLO
	mail-px0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755108AbZGYGmC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 02:42:02 -0400
Received: by pxi14 with SMTP id 14so686054pxi.33
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 23:42:02 -0700 (PDT)
Received: by 10.115.54.3 with SMTP id g3mr5740289wak.2.1248504122051;
        Fri, 24 Jul 2009 23:42:02 -0700 (PDT)
Received: from ?10.0.1.8? (c-76-115-234-44.hsd1.wa.comcast.net [76.115.234.44])
        by mx.google.com with ESMTPS id j34sm8141853waf.29.2009.07.24.23.42.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 23:42:01 -0700 (PDT)
In-Reply-To: <7vab2t64cg.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123993>


On Jul 24, 2009, at 4:36 PM, Junio C Hamano wrote:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> When starting a new repository, I see my students often say
>>
>>    % git init newrepo
>>
>> and curse git.  They could say
>>
>>    % mkdir newrepo; cd newrepo; git init
>>
>> but allowing it as an obvious short-cut may be nicer.
>>
>> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
>
> Hmm, I didn't realize this is so common a wish among new people.
>
> The patch seems clean.  Anybody has comments, both on code and the use
> case?

The use case makes sense.  This helps make git init be a bit more  
consistent
with git clone, which can take a trailing target.

For the code, I would replace the direct use of mkdir with  
safe_create_dir.
Otherwise it looks fine.

-Alex Scarborough
