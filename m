From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: backups with git
Date: Mon, 10 Aug 2009 09:20:59 -0400
Message-ID: <46a038f90908100620l2ddc9fa9t507990bae58d6031@mail.gmail.com>
References: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Roald de Vries <rdv@roalddevries.nl>
X-From: git-owner@vger.kernel.org Mon Aug 10 15:21:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaUoH-0002lG-TH
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 15:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbZHJNVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 09:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754569AbZHJNVA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 09:21:00 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:47674 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754232AbZHJNU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 09:20:59 -0400
Received: by bwz19 with SMTP id 19so2560206bwz.37
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UG9wg4wM3nsuDhN7Ny5tDbr9AORM/cAhjmMMY/YqvhQ=;
        b=pqVi98h4tYpHQoyw3fGi49xULW2lDnNBsjiWefHq4JUF1DR9PaH6TNSBfnvGai+HDu
         0eRBdSxSCJtxZ1rnxg10VvlHZIyGdVkZrU56MqBY7ihkveYeujsiuS1xU9ZPpK3bjlET
         OruWkJ6ZxmPUQ8cYI7b0deG4l9chRXgG7wcKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rYXzxugDwTievaIbLWwKVteJncrTTsVld1m1f2XOeJIYXefSi4I1JmYrnhakoWfjsG
         NWeNCIrS1zoX5WF+HijNmRPMVY1MggfvnqDBjimyOR4bMLnkPaZ3T+78cDYMQu4MNQ6I
         j3v9jHB8vN35BtA8wi0xfGo7F/y/unZ3BM/S8=
Received: by 10.223.104.74 with SMTP id n10mr211730fao.101.1249910459109; Mon, 
	10 Aug 2009 06:20:59 -0700 (PDT)
In-Reply-To: <41CB836B-6057-448E-805F-F25EAF765D27@roalddevries.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125441>

On Mon, Aug 10, 2009 at 4:27 AM, Roald de Vries<rdv@roalddevries.nl> wrote:
> I'm thinking of using git as a backup solution for my whole system, setting

There are lots of little problems. The two main ones are, IMHO

 - permissions & ownership
 - large files

Some ppl use it for their homedir, and it can be a moderate success as
long as they don't deal with large files.

cheers,


m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
