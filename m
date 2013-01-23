From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 1/8] git_remote_helpers: Allow building with Python 3
Date: Wed, 23 Jan 2013 10:49:12 -0800
Message-ID: <CAGdFq_hs+mP6JbLW65h1_U0JAetHyJ=HsA4sN_WCcRAs96LLew@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk> <72abc4652432c35ebb81404b41c2149d0400347a.1358686905.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 23 19:50:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty5Op-0006zO-0S
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650Ab3AWSty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:49:54 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:55854 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3AWStw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:49:52 -0500
Received: by mail-qa0-f43.google.com with SMTP id cr7so769799qab.9
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 10:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=4lCL6sPeggZPiOnFWdfcXKlmfhx8aBTszNCil4AMBqc=;
        b=wz02Exc3gzIfWqsyvVNOKneTGp4xW9qR2dPUs97EMl4GbmRsVwNMUVmc0kcLV597PP
         vTYPF69UNlzjng4/M3SsPJXFqc1z2UZKWnZV/pIi8iaEBQ8811GetnuPC62flVwiXsb2
         tTofBpnCtjQ3QWVZrGLIruulHbQE8fm0uSl5wVqNXL2svFulxDEUQlTFpcFLB8LZud2u
         zn7WwPjZ96eOijahl2uGCidFok47dj02xE7eP03W74WfePXROGeH9SGW9iFTDc/Vg4pi
         ifiadUON/qy+Dq/IUbXu2C7z0xHhfWiyGVholpl4FieSPULLntCMyyuXOtjq3GBVYQjc
         a0IA==
X-Received: by 10.224.179.67 with SMTP id bp3mr2848650qab.7.1358966992284;
 Wed, 23 Jan 2013 10:49:52 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Wed, 23 Jan 2013 10:49:12 -0800 (PST)
In-Reply-To: <72abc4652432c35ebb81404b41c2149d0400347a.1358686905.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214343>

On Sun, Jan 20, 2013 at 5:15 AM, John Keeping <john@keeping.me.uk> wrote:
> Change inline Python to call "print" as a function not a statement.
>
> This is harmless because Python 2 will see the parentheses as redundant
> grouping but they are necessary to run this code with Python 3.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

--
Cheers,

Sverre Rabbelier
