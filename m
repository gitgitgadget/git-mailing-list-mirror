From: Adam Mercer <ramercer@gmail.com>
Subject: Re: Determining if a file exists in a bare repo
Date: Tue, 4 May 2010 11:26:23 -0500
Message-ID: <o2k799406d61005040926h6d9b56f5ge48378822ec46280@mail.gmail.com>
References: <w2q799406d61005040911p8fd7c234s5e6382298129985f@mail.gmail.com> 
	<h2z8c9a061005040918s33bd5020sa89e95aedb7b8cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 18:27:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9KxX-0007sS-7S
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759739Ab0EDQ0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 12:26:47 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:33279 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759430Ab0EDQ0q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 12:26:46 -0400
Received: by yxe1 with SMTP id 1so1036265yxe.33
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=x+OrdN3UNAmTLMHORXukYha1E6kIiT4gTjNjXlzS2LE=;
        b=N04H9OToLbTMXySJKNNvlLke4hBKR5fIkMU4PNs0oF8DOUjMKYEz5Rzs/dfkdk1VX+
         fh6E0+TQOs/0U9TowsUUDGszmA8zDGuCbJaeWzZZRAHqFP6NwDLm7XHU8hLS8gTyfdHG
         r9Fj5uPvo0FPDHU19UlkOXnc9APQrut1KEsGE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=PlFQcs7PyI0/U64HHRmkM1xRLbNBUOkjermf26rmqeXErf/LXM28PFlqolVthwGK70
         uKpm0XbkdEDvWlr+XwppAi9QCEjTX4Zr0cT42rWSQNNs58ireNjEfNWNxW04OTsWbFkR
         KIqcW3g9NV6O7L3Ifr2R6kBvB60RIaUKbwuUk=
Received: by 10.90.38.13 with SMTP id l13mr2848882agl.119.1272990405560; Tue, 
	04 May 2010 09:26:45 -0700 (PDT)
Received: by 10.90.97.8 with HTTP; Tue, 4 May 2010 09:26:23 -0700 (PDT)
In-Reply-To: <h2z8c9a061005040918s33bd5020sa89e95aedb7b8cb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146322>

On Tue, May 4, 2010 at 11:18, Jacob Helwig <jacob.helwig@gmail.com> wrote:

> What about using "git ls-tree master" to get a file listing?

Good idea, thanks that seems to do the trick.

Cheers

Adam
