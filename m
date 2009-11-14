From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git svn fetch loses data
Date: Sat, 14 Nov 2009 18:25:09 +0100
Message-ID: <fabb9a1e0911140925r3f7b7806s65da03c046bf5ab4@mail.gmail.com>
References: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Victor Engmark <victor.engmark@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 18:25:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9MNV-0003sB-SN
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 18:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549AbZKNRZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 12:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755509AbZKNRZZ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 12:25:25 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:42106 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbZKNRZY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 12:25:24 -0500
Received: by fxm21 with SMTP id 21so1481224fxm.21
        for <git@vger.kernel.org>; Sat, 14 Nov 2009 09:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=lQRRlJcXz3aEiR5aiTlWK+Z841oYwuXGV2OwZqlNkg0=;
        b=HunKulsJkG2S7tmxlYSxkoDOOpL82YXVEgbAEPYWWs97sV+GhHXbnn+EB+gGd0gErO
         XuMMNJZFF0D3EkZnvYKGQUxPH3+vrlpxFqKPrHLW3XPoviDwd1Ct+vuO1ntHVE9pMZew
         0Z7Oj/lG4jG4dE2saWb2oU2mlXUhuS89c8itI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=iRdrh+5dmDuSY/bc4LQq9O4w+wIGbqpKweA14nKPxsn3rxtJpj4UdMVMK+QLdUiK8D
         ntbJItbZ4rCEjiQJFKXdyW3qoNO7/MonDzo5uF26yGshJLIXV3kiI01JgO4zRmFCLAMh
         bY2s5UHbvCc8alGOkUvfOKtwW6FPWjKCk65ts=
Received: by 10.216.89.138 with SMTP id c10mr134951wef.47.1258219529108; Sat, 
	14 Nov 2009 09:25:29 -0800 (PST)
In-Reply-To: <7d4f41f50911140907n285d72dcp7bbe802900f8bae5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132876>

Heya,

On Sat, Nov 14, 2009 at 18:07, Victor Engmark <victor.engmark@gmail.com> wrote:
> but at the end about half of the
> root directories are missing.

Can you be more specific, what is the layout of your repository and
which directories are missing?

/ -- trunk
  -- branches
  -- tags
  -- thirdparty
  -- private

If your repository looks like that, and 'thirdparty' and 'private' are
missing, that's because git svn assumes that you're only interested in
trunk, branches and tags by default.

-- 
Cheers,

Sverre Rabbelier
