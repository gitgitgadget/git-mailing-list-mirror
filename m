From: David Rhodes Clymer <david@zettazebra.com>
Subject: Custom git completion
Date: Fri, 29 Jan 2010 07:57:16 -0500
Message-ID: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001636e0b9c5ce372b047e4d2c47
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 29 14:02:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaqU7-0007xh-4D
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 14:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0A2M5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 07:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754502Ab0A2M5R
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 07:57:17 -0500
Received: from mail-pz0-f189.google.com ([209.85.222.189]:41256 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab0A2M5R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 07:57:17 -0500
Received: by pzk27 with SMTP id 27so1496151pzk.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 04:57:16 -0800 (PST)
Received: by 10.142.120.3 with SMTP id s3mr589053wfc.35.1264769836135; Fri, 29 
	Jan 2010 04:57:16 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138316>

--001636e0b9c5ce372b047e4d2c47
Content-Type: text/plain; charset=ISO-8859-1

Unless I read it incorrectly, the completion script included with
git-core does not make it easy for users to write completion scripts
for custom git commands. I can extend git itself by creating a command
"git-foo", and placing it in my path. The command can then be used
like so: "git foo". However, if I want to add command completion for
that command without modifying (I may not have permission) or
duplicating the system git completion, I can't write a completion
script which matches works on "git foo", only "git-foo", which is not
how I would ever call the script.

Anyway, so I made a simple modification which looks for completion
code for custom commands, and calls that as appropriate. If the
attached patch (or something like it) were applied to the git
completion script, it would be awfully handy.

-davidc

ps. I'm not subscribed to the list, so please copy me on any replies, thanks!

--001636e0b9c5ce372b047e4d2c47
Content-Type: text/x-patch; charset=US-ASCII; name="git_completion.patch"
Content-Disposition: attachment; filename="git_completion.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g50z3ysr0

LS0tIC9ldGMvYmFzaF9jb21wbGV0aW9uLmQvZ2l0Lm9yaWcJMjAxMC0wMS0xMiAxNDo1MDoxNi4w
MDAwMDAwMDAgLTA1MDAKKysrIC9ldGMvYmFzaF9jb21wbGV0aW9uLmQvZ2l0CTIwMTAtMDEtMTIg
MTU6Mjg6MjcuMDAwMDAwMDAwIC0wNTAwCkBAIC0xNDAzLDcgKzE0MDMsMTAgQEAKIAlzdm4pICAg
ICAgICAgX2dpdF9zdm4gOzsKIAl0YWcpICAgICAgICAgX2dpdF90YWcgOzsKIAl3aGF0Y2hhbmdl
ZCkgX2dpdF9sb2cgOzsKLQkqKSAgICAgICAgICAgQ09NUFJFUExZPSgpIDs7CisJKikKKyAgICBD
T01QUkVQTFk9KCkKKyAgICAkKGNvbXBsZXRlIC1wIHxhd2sgJy8gJyJnaXQtJHtjb21tYW5kfSIn
JC97cHJpbnQgJChORi0xKX0nKQorICA7OwogCWVzYWMKIH0KIAo=
--001636e0b9c5ce372b047e4d2c47--
