From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 9/9] completion: remove __git_index_file_list_filter()
Date: Sat, 27 Apr 2013 20:45:39 -0500
Message-ID: <CAMP44s0kqMVFF-PGJSiRJ9TYpA8UQrdbEUumMRuL=FDGtg0B3A@mail.gmail.com>
References: <1367093407-8898-1-git-send-email-felipe.contreras@gmail.com>
	<1367093407-8898-10-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cSp2wsvZaJ1vKn3UOGL4FyGFj4j4OFKQAeN-pVNMYZKaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 03:45:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWGgU-0001dj-6g
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 03:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755178Ab3D1Bpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 21:45:42 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:63602 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894Ab3D1Bpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 21:45:41 -0400
Received: by mail-lb0-f181.google.com with SMTP id 13so2681813lba.12
        for <git@vger.kernel.org>; Sat, 27 Apr 2013 18:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=TspK/NPGy/BBwo4OzRaMQ9TfGj/FJBBb2EVDeZ67pd4=;
        b=E7olsXXtB5n9Pc1QAKMvGvFskbkM09lGC5upfIzyYzZIpmYr0e6pcvInYshvmj5ZO7
         Ic1O1+slyeqoFTbceWthTWFvXiDoZL8l3Nv9K2dxePUHdNPM8ekUGp9C0oRmWj8nDZo0
         n+wyURxDQkJWC1vb0+6IrrlOy27/MwuvDjCeZb547xS2VnjvAkJjlgIa+OXqGDbmZwFX
         2frqkFJVBQ8eSUYFpwTs7vgLxBnwsN0Ow/l5H/uWwgHIhIYA9KldwKAbrkRYh5c6iCLE
         MkNbNKkaThIabUF6DJNoCETz64l8mNgGlueNxv8Zp3Jzzw+1D/k3ntv0jryDzrTl/m5K
         ugxQ==
X-Received: by 10.112.163.6 with SMTP id ye6mr24167756lbb.59.1367113539787;
 Sat, 27 Apr 2013 18:45:39 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sat, 27 Apr 2013 18:45:39 -0700 (PDT)
In-Reply-To: <CAPig+cSp2wsvZaJ1vKn3UOGL4FyGFj4j4OFKQAeN-pVNMYZKaw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222721>

On Sat, Apr 27, 2013 at 8:41 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Apr 27, 2013 at 4:10 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Refactor the code into the only caller; __git_index_files().
>>
>> Also, Somehow messing up with the 'path' variable messes up the 'PATH'
>
> s/Somehow/somehow/
> s/messing up/messing/

More important than that is the fact that the problem is only on zsh.

-- 
Felipe Contreras
