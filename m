From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Wed, 25 Nov 2009 11:07:29 +0100
Message-ID: <46a038f90911250207o214b3952s67a022a017dbe2d9@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
	 <4B0CEFCA.5020605@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:07:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDEmf-0007yD-L9
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:07:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758501AbZKYKHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 05:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758464AbZKYKHZ
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:07:25 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:62004 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122AbZKYKHY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 05:07:24 -0500
Received: by ewy19 with SMTP id 19so206760ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 02:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ArX7f+60pKBClcmeQdW8NGvCMWGJ2N7a9JB2WB8ZK+s=;
        b=X2X3FtfQTxwGH8rXvytVIpNl5XOxxyX5Q0h1U6KnyJ9d3JmShhl9jXRrmVLMndAQvw
         SaJ+mvogG7HvEgmp/2DOtigpgj4fLLOOxIzKjViwXKHlETKNCZkPQbyyyOIieTczP3e2
         LmNayG8Dc6XZbd9/rzWK9EwnO3CN+UzS6J/XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kI6OEL7XgmXFw+NjSH+nCR1g/LhcjIwKtLLLI8P+G6cnyVjF43ysBoVJmNLVDh8gG8
         K9UD5TJZ9cEe2AksJFqZpmwwAQcUYLxBRCDC8Fdj3xAGDLr+vWrf2AzQvsaY/Tl2PIFf
         KyayoATy3YljVnYqMz3WGpdGi6WJRLilwviA8=
Received: by 10.213.0.218 with SMTP id 26mr7614794ebc.7.1259143649731; Wed, 25 
	Nov 2009 02:07:29 -0800 (PST)
In-Reply-To: <4B0CEFCA.5020605@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133621>

On Wed, Nov 25, 2009 at 9:50 AM, Thomas Singer
<thomas.singer@syntevo.com> wrote:
> =A0toms-mac-mini:git-umlauts tom$ git stage "U\314\210berla\314\210ng=
e.txt"
> =A0fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match any =
files

does a find * | xargs git add work?

cheers,


m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
