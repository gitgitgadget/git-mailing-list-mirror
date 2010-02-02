From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Git and Amazon S3
Date: Tue, 2 Feb 2010 23:01:07 +0800
Message-ID: <be6fef0d1002020701u77910be2k95815ad887d03524@mail.gmail.com>
References: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org
To: Aneurin Price <aneurin.price@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 16:01:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcKFk-0000jT-W9
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 16:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab0BBPBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 10:01:11 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:48601 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab0BBPBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 10:01:08 -0500
Received: by iwn39 with SMTP id 39so139354iwn.1
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 07:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ojC2yuKKM+j+GREmB8oprzPcBeA5kA4csFh4APEjgiE=;
        b=hHJFwMUvpKnlXEO0PQF5duhCBtMQTvzlJtUIDKwX1c/JypTJkjarL0z16H2GjhcOvo
         Cj1nbk+3o/yPJzdxq9Rj0aGqkyQK2wfISymB61ZB4yX21do7flx6hpmKSGMn28n1F9kM
         8KNxCgPigvju6bIsU516jM7h/OHHqlIINq2SU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jpvrlaCnxxgbDONPqWj2KFT1CbC7pFw6Q4aiDYAeQnekKcrR0V7qdLOt5K0WNnp0fO
         lvmg5Fed79N6wumViopIHcsI253w6LhxRqgDplJg0W/6BJmxiiGxq1iDJohq2D47rz3K
         efKRDegeYEW2u5hakEn9lMgAjdPwXlsp9p0QU=
Received: by 10.231.146.74 with SMTP id g10mr2048394ibv.98.1265122867609; Tue, 
	02 Feb 2010 07:01:07 -0800 (PST)
In-Reply-To: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138721>

Hi,

On Tue, Feb 2, 2010 at 9:56 PM, Aneurin Price <aneurin.price@gmail.com> wrote:
> Does anyone have any remarks about these options? Is there a better option - how
> difficult would it be to add native support to git? Are there any other options
> for more git-friendly remote storage at a comparable price? Or maybe I should
> just give up, spend more and get a Linode; then I'd have the flexibility to do
> whatever I want with it.

being a backup, I believe you can just sync your .git folder one-way,
with your local copy being the authoritative one, and the S3 one just
following it.

-- 
Cheers,
Ray Chuan
