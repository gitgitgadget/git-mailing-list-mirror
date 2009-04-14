From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3 08/13] send-email: Remove superfluous `my $editor = 
	...'
Date: Mon, 13 Apr 2009 19:43:08 -0500
Message-ID: <b4087cc50904131743u304af7cctda582774e0d55059@mail.gmail.com>
References: <1239647037-15381-1-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-3-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-4-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-5-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-6-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-7-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-8-git-send-email-mfwitten@gmail.com>
	 <1239647037-15381-9-git-send-email-mfwitten@gmail.com>
	 <49E3CD48.1010809@gmail.com>
	 <b4087cc50904131741h70668a48ta52797722e9fdf38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 02:44:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtWlZ-0001GK-R3
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 02:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433AbZDNAnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 20:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZDNAnK
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 20:43:10 -0400
Received: from mail-qy0-f117.google.com ([209.85.221.117]:59658 "EHLO
	mail-qy0-f117.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753736AbZDNAnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 20:43:09 -0400
Received: by qyk15 with SMTP id 15so290986qyk.33
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 17:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=35QMsphDYtOakpao2wGE2V8kdZItDEUotTOjBd1c+4s=;
        b=x6GQjc8WsFAOZUZis255gEX7UHy/SET9BgpRDSV+32P8YtVqPHK47kgaB4sfJ2+jIu
         FVnit5NiCGEKE67eN/b56OvW6CQfkwPhzuPwnWBRjtcq8Vx0VGxQsHEJOA5tpgvjIuGT
         a5AkCxPKybljFtB+AUnas7KeAzUM2BGRy7Cco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nC7zGyP+8Lrnv/U/NJ5McW6lq2/wTUY3171k8VadAYBiO64MddKiwgsYmeBcJWQ9iA
         JoeGrCh3k8jDQPWYA+ibWdopd9SWO7cVCDXxK4YDy7xNT/S3c9k7SgjaURKWNhSiNP19
         N+jSyeuwpbHxcwcG39a4WOMBmfqIWaHAix3tA=
Received: by 10.224.80.193 with SMTP id u1mr6793784qak.353.1239669788547; Mon, 
	13 Apr 2009 17:43:08 -0700 (PDT)
In-Reply-To: <b4087cc50904131741h70668a48ta52797722e9fdf38@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116506>

On Mon, Apr 13, 2009 at 19:41, Michael Witten <mfwitten@gmail.com> wrote:
> On Mon, Apr 13, 2009 at 18:39, Stephen Boyd <bebarino@gmail.com> wrote:
>> I don't want to start an editor war, but why is 'vi' here?
>
> The program vi is on every single Unix installation. Take that as an axiom.

However, I would be OK with confronting the user about setting one of
the variables.
