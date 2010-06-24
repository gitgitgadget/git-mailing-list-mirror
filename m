From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 8/9] Add SVN dump parser
Date: Thu, 24 Jun 2010 22:33:43 +0200
Message-ID: <AANLkTimql4TtCvkbgZg2nWhPGDhc1nkQpOJAaiRSxyS5@mail.gmail.com>
References: <20100624105004.GA12336@burratino> <20100624110325.GH12376@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 24 22:34:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORt7k-00052e-8C
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 22:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192Ab0FXUeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 16:34:07 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64972 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979Ab0FXUeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 16:34:05 -0400
Received: by vws9 with SMTP id 9so2914345vws.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=Ch7iXWvMcrdGyi6So2AcDnOCC7yEucoGIChZoH98RDo=;
        b=UUJqFaL65Za+I8c7Ah1lvvXTB524bJWGhAT2x2HWByM5TI0TOVwuvXUgdqSEbMAHih
         3+M89A+grVKKw9hEXRJBbF29CaxsnmbV0l8aXi7jhkdwCrj/N/Q1rgncjG++OQqF7kG+
         wIGZEHMdc2m35qZ5orekKHcc288UrlwA4NOxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vJawO4bkj89m6eUAMTed0UGp8PeWpdmJZy3C4YHQU4NFYzWEcS8w2qDYP66QsOQRmr
         PquAob3p/NjWEXhDtDYHTbOOY5zDe6Dw7MEnHkw7rixvRiUHkzpwsWpglth2oCr8He3d
         +CCP6OnnCtPC8j4vVWIrAKPJfJ1a1kv/NvvBI=
Received: by 10.224.72.78 with SMTP id l14mr6809611qaj.116.1277411643408; Thu, 
	24 Jun 2010 13:34:03 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Thu, 24 Jun 2010 13:33:43 -0700 (PDT)
In-Reply-To: <20100624110325.GH12376@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149640>

Hi,

Jonathan Nieder wrote:
> svndump parses data that is in SVN dumpfile format produced by
> `svnadmin dump` with the help of line_buffer and uses repo_tree and
> fast_export to emit a git fast-import stream.

This hasn't changed from last time, and isn't expected to change in
future. Should go in without any issues, although I'd love it if we
could somehow refactor the huge if-else tree. Again, I'm not sure if
this is appropriate since I've already signed off:
Reviewed-by: Ramkumar Ramachandra <artagnon@gmail.com>

-- Ram
