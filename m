From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] git-completion.bash: prevent 'git help' from searching 
	for git repository
Date: Wed, 2 Sep 2009 13:47:31 +0200
Message-ID: <fabb9a1e0909020447p212594cake8c6fe3a43b667ec@mail.gmail.com>
References: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Wed Sep 02 13:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MioOv-0007XN-N5
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 13:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856AbZIBLxH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 07:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbZIBLxH
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 07:53:07 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:33058 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZIBLxF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 07:53:05 -0400
Received: by ey-out-2122.google.com with SMTP id 25so164330eya.19
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PfSj3qxZ5adTWQges8dx97sO0HYMNDhR2Y1xtxSUMtE=;
        b=RoxxAhgkN+QBAQmxHzitZt5rIpcsMiiMNBSr4uBUUhixdd+4lNJucR+kgQrj5CTxt2
         w6dhzrtM7xI55Fj+utyma9wyWqrteCl32a7bsN/eOslm0OjCms+cknuE7tJ+DfcJfH6f
         IkqLKEBZQ83EC8YPSjgWIFHglh84XRy4dyc4M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=dc7vSVGHpsy0egYoxYpF/+MYmcrcwkZD/9vIZAkZc4c5HJsckkWWyayF2YTeU9tcmH
         Q4bScPt6giurR4HtRjS6zBeRKi93zFIsnqwpXxQs1Lp/4kmc3saXEF2WAdFyMlJ+fLlX
         T7CT0uw6Tq7WF2Kd/HG6XatmQeJTXwtMFOfp0=
Received: by 10.216.54.207 with SMTP id i57mr125301wec.114.1251892071203; Wed, 
	02 Sep 2009 04:47:51 -0700 (PDT)
In-Reply-To: <20090902095843.28914.qmail@3cd9dde586d86b.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127604>

Heya,

On Wed, Sep 2, 2009 at 11:58, Gerrit Pape<pape@smarden.org> wrote:
> + =A0 =A0 =A0 for i in $(git --git-dir=3D/nonexistent help -a|egrep '=
^ ')

Wouldn't implementing "git --no-git-dir" be more appropriate?

--=20
Cheers,

Sverre Rabbelier
