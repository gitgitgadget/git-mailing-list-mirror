From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] gitk: new option to hide remote refs
Date: Tue, 4 Aug 2009 11:44:31 +0200
Message-ID: <adf1fd3d0908040244m1c7d45ffw67be74091da74730@mail.gmail.com>
References: <55b7e43bcd59aa64c70edde83ac87147aa0091bb.1249336225.git.trast@student.ethz.ch>
	 <7vab2g6qkd.fsf@alter.siamese.dyndns.org>
	 <200908041108.19108.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Thell Fowler <tbfowler4@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 04 11:44:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYGZX-00053a-5W
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 11:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932737AbZHDJod convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 05:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932726AbZHDJod
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 05:44:33 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:41404 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932689AbZHDJoc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 05:44:32 -0400
Received: by ewy10 with SMTP id 10so177698ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 02:44:31 -0700 (PDT)
Received: by 10.216.89.137 with SMTP id c9mr1431458wef.80.1249379071282; Tue, 
	04 Aug 2009 02:44:31 -0700 (PDT)
In-Reply-To: <200908041108.19108.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124775>

2009/8/4 Thomas Rast <trast@student.ethz.ch>:
> Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>> > - =A0 =A0 =A0 if {![string match "*/HEAD" $name]} {
>> > + =A0 =A0 =A0 if {![string match "*/HEAD" $name] && !$hideremotes}=
 {
>>
>> Hmm, I wonder if it would be more useful to extend this by using $sk=
iprefs
>> pattern instead, like so:
> [...]
>> + =A0 =A0 if {$skiprefs !=3D "" && [string match $skiprefs $name]} c=
ontinue
>
> Shortly after sending the patch, I had another idea: how about an
> option to only show refs that were given on the command line, if any?
> That way 'gitk --branches' or 'gitk HEAD' would hide the whole remote=
s
> mess (and of course also all other refs in the process). =A0I think I
> might be able to voodoo enough Tk to implement this.

Another possibility could be to have just an indication that the
commit has branches and/or tags pointing to it. Maybe just as it is
now but without the branch/tag name.

To mimic the current UI it could be:

o-<|-|_| Commit summary

with:

 o the current circle
 <| a yellow triangle
 |_| a green square

and then if you click on them you could get the current view, or a
list of branches/tags in the lower panel.

my 2 cents,
Santi
