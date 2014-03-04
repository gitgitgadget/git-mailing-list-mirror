From: David Kastrup <dak@gnu.org>
Subject: Re: git compile with debug symbols
Date: Tue, 04 Mar 2014 17:43:13 +0100
Message-ID: <8761ntj4ny.fsf@fencepost.gnu.org>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
	<87a9d6hsf3.fsf@fencepost.gnu.org> <vpqtxbene6o.fsf@anie.imag.fr>
	<1393950801.57403.YahooMailNeo@web162903.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:43:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKsRh-00014k-CZ
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:43:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbaCDQnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 11:43:33 -0500
Received: from fencepost.gnu.org ([208.118.235.10]:50792 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbaCDQn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 11:43:29 -0500
Received: from localhost ([127.0.0.1]:49835 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1WKsRE-00065Q-4p; Tue, 04 Mar 2014 11:43:28 -0500
Received: by lola (Postfix, from userid 1000)
	id 8423DE0526; Tue,  4 Mar 2014 17:43:13 +0100 (CET)
In-Reply-To: <1393950801.57403.YahooMailNeo@web162903.mail.bf1.yahoo.com>
	(Mahesh Pujari's message of "Tue, 4 Mar 2014 08:33:21 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243357>

Mahesh Pujari <pujarimahesh_kumar@yahoo.com> writes:

> Thanks David for the reply. I think I need to do more ground work of
> going through how to use gdb.
> Basically I am java programmer and I was trying out to debug git
> source using eclipse CDT and as we do in java, I was trying out to set
> break point but failed with errors as "No line 396 in file "help.c"".
> And using gdb too I end up with same error.
>
> # (gdb) break help.c:396
> # No line 396 in file "help.c".
>
>
> Am I missing something.

There is just no line 396 known to gdb.  It seems like you are
indicating a function header.  That's not code.  Either take the
function _name_ rather than a line number (that's usually most reliable)
or take the first line of actual code.

-- 
David Kastrup
