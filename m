From: Aaron Bentley <aaron.bentley@utoronto.ca>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 12:56:27 -0400
Message-ID: <453A513B.1070006@utoronto.ca>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>	<4536EC93.9050305@utoronto.ca>	<845b6e870610190002u420118b8ud634bb9594572c48@mail.gmail.com>	<46d6db660610190149x32442596we4112cdd044185a@mail.gmail.com>	<45373E27.3050209@op5.se>
	<vpqwt6wsmb5.fsf@ecrins.imag.fr>	<72877ab10610190757u3d2b4df0o204c6ffd73af69b4@mail.gmail.com>	<45379A02.1010105@utoronto.ca>	<72877ab10610192014o3a7f66c6v79f94f48615e08f4@mail.gmail.com>	<45384B0F.4040901@utoronto.ca>	<20061021123027.GB29843@artax.karlin.mff.cuni.cz>
	<ehd5u7$c5g$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: bazaar-ng-bounces@lists.canonical.com Sat Oct 21 18:56:50 2006
Return-path: <bazaar-ng-bounces@lists.canonical.com>
Envelope-to: gcvbg-bazaar-ng@m.gmane.org
Received: from esperanza.ubuntu.com ([82.211.81.173])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbK9R-00062e-DR
	for gcvbg-bazaar-ng@m.gmane.org; Sat, 21 Oct 2006 18:56:49 +0200
Received: from localhost ([127.0.0.1] helo=esperanza.ubuntu.com)
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <bazaar-ng-bounces@lists.canonical.com>)
	id 1GbK9F-0002Pp-QX; Sat, 21 Oct 2006 17:56:37 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41])
	by esperanza.ubuntu.com with esmtp (Exim 4.60)
	(envelope-from <aaron.bentley@utoronto.ca>) id 1GbK9D-0002Pj-IY
	for bazaar-ng@lists.canonical.com; Sat, 21 Oct 2006 17:56:35 +0100
Received: from server4.panoramicfeedback.com ([66.216.124.41] helo=[127.0.0.1])
	by server4.panoramicfeedback.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GbK97-0001rW-00; Sat, 21 Oct 2006 12:56:29 -0400
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehd5u7$c5g$1@sea.gmane.org>
X-Enigmail-Version: 0.94.0.0
X-Panometrics-MailScanner: Found to be clean
X-BeenThere: bazaar-ng@lists.canonical.com
X-Mailman-Version: 2.1.8
Precedence: list
List-Id: bazaar-ng discussion <bazaar-ng.lists.canonical.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/bazaar-ng>
List-Post: <mailto:bazaar-ng@lists.canonical.com>
List-Help: <mailto:bazaar-ng-request@lists.canonical.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/bazaar-ng>,
	<mailto:bazaar-ng-request@lists.canonical.com?subject=subscribe>
Sender: bazaar-ng-bounces@lists.canonical.com
Errors-To: bazaar-ng-bounces@lists.canonical.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29636>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jakub Narebski wrote:
> Jan Hudec wrote:
> 
>> On Fri, Oct 20, 2006 at 12:05:35AM -0400, Aaron Bentley wrote:
>>> Tim Webster wrote:
>>>> Also svn does not allow files in the same directory to live in
>>>> multiple repos
>>> It would surprise me if many SCMs that support atomic commit also
>>> support intermixing files from multiple repos in the same directory.
>> In fact I think svk would. You would have to switch them by setting
>> an environment variable, but it's probably doable. That is because
>> unlike other version control systems, it does not store the information
>> about checkout in the checkout, but in the central directory and that
>> can be set. I don't know git well enough to tell whether git could do
>> the same by setting GIT_DIR.
> 
> You can very simply embed one "clothed" repository into another in GIT,
> like shown below
> 
>   project/.git
>   project/subdir/
>   project/subdir/file
>   project/subproject/
>   project/subproject/.git
>   project/subproject/file
>   ...
> 
> It depends on circumstances if one wants files belonging to subdirectory
> be ignored by top repository. You would want to ignore .git/ directory,
> though.

Any SCM worth its salt should support that.  AIUI, that's not what Tim
wants.  He wants to intermix files from different repos in the same
directory.

i.e.

project/file-1
project/file-2
project/.git-1
project/.git-2

So file-1 would be in the .git-1 repository, but file-2 would be in the
.git-2 repository.

Aaron
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFOlE70F+nu1YWqI0RAvNcAJ0Rd6ovGoBNtKxcPNOrMH1yc+bzWQCfQlqT
hREsUmCBAW8mIYzfzdnqZqU=
=unGE
-----END PGP SIGNATURE-----
