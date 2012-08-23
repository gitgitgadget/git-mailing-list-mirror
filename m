From: Gokulramkumar Subramaniam <goksubra@umail.iu.edu>
Subject: Reg:Git-ssh bug
Date: Thu, 23 Aug 2012 18:22:01 -0400
Message-ID: <02C1EA56-2145-4FD5-9FD2-377514C12704@umail.iu.edu>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 24 00:22:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4fml-0006gT-C1
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 00:21:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682Ab2HWWVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 18:21:49 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:64334 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754115Ab2HWWVr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2012 18:21:47 -0400
Received: by qaas11 with SMTP id s11so135203qaa.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 15:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer:x-gm-message-state;
        bh=Anc2AsMJoPdZXs8ytdu4MhqRy41U9aX2Hfa7YlYhT8M=;
        b=mMFblnRWRAyftdv2cOOGjZaoEIPZVoWUhhIrH/SM/iAjrMvRqAvuUTSM59N7gjEj22
         4di4CAzb0n3a6HD832/kaldwcZW2sdVJ11/3Oj/jUb59J+CLIWtVaoH5Pt6MqopXD+L3
         1OZ1lOZzBoO9iE3otgOLcZEW8f1vATuGmKdMtpKZu6R58TZ8GkreYVFCJyipLE70AFyc
         8Us9x7Kb0U+gCyHF+Ms7D7POKEIxWJO1g/MqtJ3MUwp7FGAbM/5/o3PsbiptYtcem9E+
         d9CO+UkE98/e8ykWsC85Br8yB/DjXzhyz+jA7QP8K5Lck5c90IFare869Si4PqtduwHv
         1ZMg==
Received: by 10.224.185.70 with SMTP id cn6mr5531147qab.16.1345760506771;
        Thu, 23 Aug 2012 15:21:46 -0700 (PDT)
Received: from 140-182-136-118.dhcp-bl.indiana.edu (140-182-136-118.dhcp-bl.indiana.edu. [140.182.136.118])
        by mx.google.com with ESMTPS id a13sm6107574qad.18.2012.08.23.15.21.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 23 Aug 2012 15:21:46 -0700 (PDT)
X-Mailer: Apple Mail (2.1280)
X-Gm-Message-State: ALoCoQn060wdJZPa7TTt4N7eEQAtCujULWT7vfnLJ2YlOkPVv7Y0DnTf0OululPyJtLNtPoYTjQh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204178>

Hi,

I am new to Git and I am trying to add my machine with Git but it is failing through ssh method.

Error received:

$ ssh-add -l
2048 5f:6f:39:ed:b0:76:2e:d0:xx:xx:xx:xx:xx:xx:xx:xx id_rsa (RSA)

Gokul$ ssh -vT git@github.com
OpenSSH_5.6p1, OpenSSL 0.9.8r 8 Feb 2011
debug1: Reading configuration data /etc/ssh_config
debug1: Applying options for *
debug1: Connecting to github.com [207.97.227.239] port 22.
debug1: Connection established.
debug1: identity file /Users/Gokul/.ssh/id_rsa type 1
debug1: identity file /Users/Gokul/.ssh/id_rsa-cert type -1
debug1: identity file /Users/Gokul/.ssh/id_dsa type -1
debug1: identity file /Users/Gokul/.ssh/id_dsa-cert type -1
debug1: Remote protocol version 2.0, remote software version OpenSSH_5.5p1 Debian-6+squeeze1+github8
debug1: match: OpenSSH_5.5p1 Debian-6+squeeze1+github8 pat OpenSSH*
debug1: Enabling compatibility mode for protocol 2.0
debug1: Local version string SSH-2.0-OpenSSH_5.6
debug1: SSH2_MSG_KEXINIT sent
debug1: SSH2_MSG_KEXINIT received
debug1: kex: server->client aes128-ctr hmac-md5 none
debug1: kex: client->server aes128-ctr hmac-md5 none
debug1: SSH2_MSG_KEX_DH_GEX_REQUEST(1024<1024<8192) sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_GROUP
debug1: SSH2_MSG_KEX_DH_GEX_INIT sent
debug1: expecting SSH2_MSG_KEX_DH_GEX_REPLY
debug1: Host 'github.com' is known and matches the RSA host key.
debug1: Found key in /Users/Gokul/.ssh/known_hosts:1
debug1: ssh_rsa_verify: signature correct
debug1: SSH2_MSG_NEWKEYS sent
debug1: expecting SSH2_MSG_NEWKEYS
debug1: SSH2_MSG_NEWKEYS received
debug1: Roaming not allowed by server
debug1: SSH2_MSG_SERVICE_REQUEST sent
debug1: SSH2_MSG_SERVICE_ACCEPT received
debug1: Authentications that can continue: publickey
debug1: Next authentication method: publickey
debug1: Offering RSA public key: id_rsa
debug1: Authentications that can continue: publickey
debug1: Offering RSA public key: /Users/Gokul/.ssh/id_rsa
debug1: Authentications that can continue: publickey
debug1: Trying private key: /Users/Gokul/.ssh/id_dsa
debug1: No more authentication methods to try.
Permission denied (publickey).

Please let me know, what I need to follow to get rid of this problem.

Regards,
Gokulramkumar Subramaniam