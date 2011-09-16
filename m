From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] ls-remote: a lone "-h" is asking for help
Date: Fri, 16 Sep 2011 21:09:23 +0200
Message-ID: <CAGdFq_h474OrLzP+CHj_eSdSp53n8x7jz1ORT16dOhvRdQMP+g@mail.gmail.com>
References: <7vobykfj7g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 21:14:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4drf-00082N-NL
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 21:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755948Ab1IPTOP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 15:14:15 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37296 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753832Ab1IPTOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 15:14:14 -0400
Received: by gxk6 with SMTP id 6so2525450gxk.19
        for <git@vger.kernel.org>; Fri, 16 Sep 2011 12:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=WU4xMiGpg+q+CrDQbo/H5BncvrTOX+QoF2Gjm1tPOD8=;
        b=BsGQE0Z8DlFQ7Pz35xaBeJL5ZLtk1ExmoL8MUwDf6OzsEXnNYQuz2BD+gg2FZW6kem
         AaTbDXDOT5L2URzNqtDVU2Wr87v5YqqkyfIsBstc8Ani/GY1zoAG2EN6rxGE+97/jNbP
         cJEjNnBLIjY073BJUFV0EYXbWrz13VnQuHzhU=
Received: by 10.68.14.163 with SMTP id q3mr91782pbc.98.1316200453338; Fri, 16
 Sep 2011 12:14:13 -0700 (PDT)
Received: by 10.68.59.39 with HTTP; Fri, 16 Sep 2011 12:09:23 -0700 (PDT)
In-Reply-To: <7vobykfj7g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181545>

Heya,

On Fri, Sep 16, 2011 at 20:14, Junio C Hamano <gitster@pobox.com> wrote:
> It does not give a short-help for the command. Instead because "-h" is a
> synonym for "--heads", it runs "git ls-remote --heads", and because there
> is no remote specified on the command line, we run it against the default
> "origin" remote, hence end up doing the same as

Should we really have "-h" as a short for anything other than "--help"
in the first place?

-- 
Cheers,

Sverre Rabbelier
