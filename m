From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 05/21] notes.h/c: Clarify the handling of notes objects that are == null_sha1
Date: Fri, 22 Oct 2010 15:32:24 +0200
Message-ID: <201010221532.24436.johan@herland.net>
References: <1287626936-32232-1-git-send-email-johan@herland.net> <201010211513.06176.johan@herland.net> <20101021175404.GC11328@burratino>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 15:41:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Hry-0001UQ-BE
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 15:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756388Ab0JVNlJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 09:41:09 -0400
Received: from smtp.opera.com ([213.236.208.81]:39261 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755283Ab0JVNlH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 09:41:07 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o9MDWOnO030700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 22 Oct 2010 13:32:24 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20101021175404.GC11328@burratino>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159686>

On Thursday 21 October 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> >   Allow combine_notes functions to request that a note be removed,
> >   by setting the resulting note SHA1 to null_sha1 (0000000...).
> >
> >   For consistency, also teach note_tree_insert() to skip insertion
> >   of an empty note when there is no note to combine it with.
>
> I guess it's probably also worth clarifying that the term "empty
> note" means null_sha1 rather than empty_blob_sha1.
>
> i.e. something like:
>
> 	For consistency, also teach note_tree_insert() to skip insertion
> 	of an empty note (a note with val_sha1 equal to null_sha1)
> 	when there is no note to combine it with.

Agreed. Incorporated.

> The previous behavior iiuc would have been for write_notes_tree() to
> write invalid trees after such an operation.

Indeed, you are correct. I've added a note about this to the commit 
message.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
