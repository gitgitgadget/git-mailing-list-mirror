From: Junio C Hamano <gitster@pobox.com>
Subject: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Wed, 05 Aug 2009 15:04:10 -0700
Message-ID: <7vd479x6hx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 06 00:04:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYoaw-0005fI-Ip
	for gcvg-git-2@gmane.org; Thu, 06 Aug 2009 00:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZHEWEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 18:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbZHEWEP
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 18:04:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZHEWEO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 18:04:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 80DCC1ED0A;
	Wed,  5 Aug 2009 18:04:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 988CA1ED09; Wed,  5 Aug 2009
 18:04:12 -0400 (EDT)
X-maint-at: f0df1293acdba9513cae17e2c63b4169f1347371
X-master-at: 3f55e4107f7906134df029f9a5c44864f9258110
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E9B5FE94-820B-11DE-B762-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125004>

The 1.6.4 release seems to have been quite solid, and there is no
brown-paper-bag bugfixes on 'maint' yet ;-).

A handful of topics have graduated to 'master'.

* The 'maint' branch has these fixes since the last announcement.

Bj=C3=B6rn Steinbrink (1):
  config: Keep inner whitespace verbatim

Erik Faye-Lund (1):
  send-email: remove debug trace

Jakub Narebski (1):
  gitweb/README: Document $base_url

Jens Lehmann (1):
  Documentation: git submodule: add missing options to synopsis

Matthieu Moy (1):
  Better usage string for reflog.

Miklos Vajna (1):
  hg-to-git: don't import the unused popen2 module


* The 'master' branch has these since the last announcement
  in addition to the above.

Andr=C3=A9 Goddard Rosa (1):
  Fix typos on pt_BR/gittutorial.txt translation

Geoffrey Irving (1):
  git fast-export: add --no-data option

Giuseppe Bilotta (1):
  gitweb: fix 'Use of uninitialized value' error in href()

Jeff King (2):
  show: suppress extra newline when showing annotated tag
  show: add space between multiple items

Johannes Schindelin (1):
  parse-opt: optionally show "--no-" option string

Junio C Hamano (1):
  apply: notice creation/removal patches produced by GNU diff

Michael J Gruber (3):
  t6010-merge-base.sh: Depict the octopus test graph
  git-merge-base/git-show-branch: Cleanup documentation and usage
  git-merge-base/git-show-branch --merge-base: Documentation and test

Micha=C5=82 Kiedrowicz (1):
  init-db: migrate to parse-options

Nanako Shiraishi (1):
  git init: optionally allow a directory argument

Nick Edelen (1):
  Shift object enumeration out of upload-pack

Santi B=C3=A9jar (2):
  t5520-pull: Test for rebased upstream + fetch + pull --rebase
  pull: support rebased upstream + fetch + pull --rebase

Stephen Boyd (7):
  read-tree: convert unhelpful usage()'s to helpful die()'s
  read-tree: migrate to parse-options
  write-tree: migrate to parse-options
  verify-tag: migrate to parse-options
  verify-pack: migrate to parse-options
  prune-packed: migrate to parse-options
  technical-docs: document tree-walking API

Wesley J. Landaker (2):
  Documentation: git-send-email: fix submission port number
  Documentation: git-send-email: correct statement about standard ports
