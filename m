From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Submodule URL
Date: Mon, 27 Jun 2011 15:38:01 -0700
Message-ID: <BANLkTikyZxiW_t27Y4bXCPBjbJd_DYbOyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=20cf305b126630e30d04a6b93411
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 28 00:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbKVp-0001EM-Na
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 00:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab1F0WjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 18:39:05 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46780 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754456Ab1F0WiD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 18:38:03 -0400
Received: by gyh3 with SMTP id 3so2026833gyh.19
        for <git@vger.kernel.org>; Mon, 27 Jun 2011 15:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=QLr1g7IrIesn6SJwsbtZEiGf8BBWZE+oBNMU1afEhHM=;
        b=RtHFCgzyFHr7awfQ8c8+1iJ6SBWakvZavhisP73efyJkyt6Wcx8MikljFMyvkBjRDT
         U8BtlbgnkUfNifCgiAXJMyRFCiDMPiHr4dm8GL0qsqZbIBc7TxlUfjDn+fqD+VSimUp0
         P8xPm/S8vZwXtmGZF0zSwLt1u+54xk5UBBn7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Av4wUE7xnM/kOIcoMannsEjuONSseWWJZfQbZqN61mbbn7/tmqBenYZlNIxo2YrIup
         wArzGuhES6Y0WyQPe8Xb/ICo3INy0eYn3r6eYvZ1FGjI0ThavtaHPyBMMRGawO5jMfqC
         8KSJdCNPu+KPRVlSggVz3p3iXkmFx4cOj4fz4=
Received: by 10.236.181.39 with SMTP id k27mr10628527yhm.7.1309214281622; Mon,
 27 Jun 2011 15:38:01 -0700 (PDT)
Received: by 10.236.202.65 with HTTP; Mon, 27 Jun 2011 15:38:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176376>

--20cf305b126630e30d04a6b93411
Content-Type: text/plain; charset=UTF-8

Hi all,

As I was creating a script to support a question about submodules I
ran into something that I don't understand. I've attached a simple
script that fails to execute properly. I don't understand why.

In essence, I'm setting up 2 separate, bare repositories on the local
file system. One is intended to be a submodule, the other the umbrella
project. I then try to clone the umbrella project. Although I use
complete, absolute file:// URLs git submodule update --init fails
because .gitmodules uses a relative URL instead of the absolute URL I
provided initially. (Naturally, a relative URL could work too but it
would have to be a different one.) :-)

Should I use a different syntax? Or are file:// URLs not supported for
submodules? Or am I simply misunderstanding how this is supposed to
work?

Cheers,
Hilco

--20cf305b126630e30d04a6b93411
Content-Type: application/octet-stream; name=submodule-repo
Content-Disposition: attachment; filename=submodule-repo
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gpg00qk10

IyEvYmluL2Jhc2gKClJPT1Q9JChwd2QpCkRJUj0kUk9PVC8kKGRhdGUgKyVZJW0lZCVIJU0lUykK
ClJFTU9URT0kRElSL3JlbW90ZQpMT0NBTD0kRElSL2xvY2FsCgpta2RpciAtcCAkTE9DQUwKCmNk
ICRMT0NBTApnaXQgaW5pdCAtLWJhcmUgJFJFTU9URS90aGUtbW9kdWxlLXJlcG8KZ2l0IGNsb25l
IGZpbGU6Ly8kUkVNT1RFL3RoZS1tb2R1bGUtcmVwbyB0aGUtbW9kdWxlCmNkIHRoZS1tb2R1bGUK
dG91Y2ggdGhlLW1vZHVsZS1maWxlLnR4dApnaXQgYWRkIHRoZS1tb2R1bGUtZmlsZS50eHQKZ2l0
IGNvbW1pdCAtbSAnVmVyc2lvbiAxLicKZ2l0IHB1c2ggb3JpZ2luIG1hc3RlcgpybSAtcmYgJExP
Q0FML3RoZS1tb2R1bGUKCmNkICRMT0NBTApnaXQgaW5pdCAtLWJhcmUgJFJFTU9URS91bWJyZWxs
YS1yZXBvCmdpdCBjbG9uZSBmaWxlOi8vJFJFTU9URS91bWJyZWxsYS1yZXBvIHVtYnJlbGxhCmNk
IHVtYnJlbGxhCnRvdWNoIGZpbGUudHh0CmdpdCBhZGQgZmlsZS50eHQKZ2l0IGNsb25lIGZpbGU6
Ly8kUkVNT1RFL3RoZS1tb2R1bGUtcmVwbyB0aGUtbW9kdWxlCmdpdCBzdWJtb2R1bGUgYWRkIC4v
dGhlLW1vZHVsZQpnaXQgY29tbWl0IC1tICdWZXJzaW9uIDEuJwpnaXQgcHVzaCBvcmlnaW4gbWFz
dGVyCnJtIC1yZiAkTE9DQUwvdW1icmVsbGEKCmNkICRMT0NBTApnaXQgY2xvbmUgZmlsZTovLyRS
RU1PVEUvdW1icmVsbGEtcmVwbyB1bWJyZWxsYQpjZCB1bWJyZWxsYQpnaXQgY2hlY2tvdXQgbWFz
dGVyCmdpdCBzdWJtb2R1bGUgdXBkYXRlIC0taW5pdCAtLXJlY3Vyc2l2ZQo=
--20cf305b126630e30d04a6b93411--
