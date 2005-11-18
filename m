From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Small script to patch .spec for Suse
Date: Thu, 17 Nov 2005 21:47:04 -0800
Message-ID: <437D6AD8.90907@gmail.com>
References: <200511151230.30030.Josef.Weidendorfer@gmx.de> <20051115215943.GW30496@pasky.or.cz> <437A5FAF.2000609@zytor.com> <200511160232.15162.Josef.Weidendorfer@gmx.de> <437D6294.8020003@zytor.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040506090003040504070003"
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 07:52:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EczSH-0007r8-5O
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 07:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbVKRFrK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 00:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVKRFrK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 00:47:10 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:14785 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964883AbVKRFrI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 00:47:08 -0500
Received: by xproxy.gmail.com with SMTP id i30so107426wxd
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 21:47:07 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=tHfnFmwAYxQ1YTXxU8Y8MWK1WmxsmgdNyM28/AAmnNUUwk/OUjYF4uaOyqVd0CoARZa61MlcqlV1bKNEEe4QojCftBXSopI7f1I7sLYqNvoclW7XWG0WzpGOJ7V4jBmlFk7pKJVX8uTAkDhKRQsKAYY+4+Oxcs2hou5j93Tw8Z0=
Received: by 10.70.73.6 with SMTP id v6mr6275076wxa;
        Thu, 17 Nov 2005 21:47:07 -0800 (PST)
Received: from ?10.0.0.6? ( [70.32.120.109])
        by mx.gmail.com with ESMTP id i19sm544392wxd.2005.11.17.21.47.06;
        Thu, 17 Nov 2005 21:47:07 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437D6294.8020003@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12202>

This is a multi-part message in MIME format.
--------------040506090003040504070003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

H. Peter Anvin wrote:
> Josef Weidendorfer wrote:
>> On Tuesday 15 November 2005 23:22, H. Peter Anvin wrote:
>>
>>> Sure.  It's called %if.  There is also %ifdef and %define.
>>
>>
>> So by replacing @@FOR_SUSE@@ to 0 or 1 in the Makefile, this:
>>  %if @@FOR_SUSE@@
>>  BuildRequires: openssh ...
>>  %else
>>  BuildRequires: openssh-clients ...
>>  %endif
>>
>> would work?
>>
> 
> SuSE might even have defined a distribution-specific macro that one can 
> key off of.  Some SuSE expert would have to comment.
> 

Attached is the output of 'rpm --showrc' on my Suse 9.3 system.

--------------040506090003040504070003
Content-Type: text/plain;
 name="Suse_9.3_rpm--showrc.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Suse_9.3_rpm--showrc.txt"

ARCHITECTURE AND OS:
build arch            : i586
compatible build archs: i686 i586 i486 i386 noarch
build os              : Linux
compatible build os's : Linux
install arch          : i686
install os            : Linux
compatible archs      : i686 i586 i486 i386 noarch
compatible os's       : Linux

RPMRC VALUES:
macrofiles            : /usr/lib/rpm/macros:/usr/lib/rpm/i686-linux/macros:/usr/lib/rpm/suse_macros:/etc/rpm/macros.specspo:/etc/rpm/macros.prelink:/etc/rpm/macros.solve:/etc/rpm/macros.up2date:/etc/rpm/macros:/etc/rpm/i686-linux/macros:~/.rpmmacros
optflags              : -O2 -g -march=i686 -mcpu=i686

Features supported by rpmlib:
    rpmlib(VersionedDependencies) = 3.0.3-1
	PreReq:, Provides:, and Obsoletes: dependencies support versions.
    rpmlib(CompressedFileNames) = 3.0.4-1
	file name(s) stored as (dirName,baseName,dirIndex) tuple, not as path.
    rpmlib(PayloadIsBzip2) = 3.0.5-1
	package payload can be compressed using bzip2.
    rpmlib(PatchRPMs) = 3.0.6-1
	understand rpms that replace a subset of files.
    rpmlib(PayloadFilesHavePrefix) = 4.0-1
	package payload file(s) have "./" prefix.
    rpmlib(ExplicitPackageProvide) = 4.0-1
	package name-version-release is not implicitly provided.
    rpmlib(HeaderLoadSortsTags) = 4.0.1-1
	header tags are always sorted after being loaded.
    rpmlib(ScriptletInterpreterArgs) = 4.0.3-1
	the scriptlet interpreter can use arguments from header.
    rpmlib(PartialHardlinkSets) = 4.0.4-1
	a hardlink file set may be installed without being complete.
    rpmlib(ConcurrentAccess) = 4.1-1
	package scriptlets may access the rpm database while installing.

========================
-14: GNUconfigure(MCs:)	
  CFLAGS="${CFLAGS:-%optflags}" ; export CFLAGS; 
  LDFLAGS="${LDFLAGS:-%{-s:-s}}"  ; export LDFLAGS; 
  %{-C:_mydir="`pwd`"; %{-M: %{__mkdir} -p %{-C*};} cd %{-C*}} 
  dirs="`find ${_mydir} -name configure.in -print`"; export dirs; 
    for coin in `echo ${dirs}` 
do 
  dr=`dirname ${coin}`; 
if test -f ${dr}/NO-AUTO-GEN; then 
 : 
else 
     macrodirs=`sed -n -e 's,AM_ACLOCAL_INCLUDE((.*)),1,gp' < ${coin}`; 
    ( cd ${dr}; 
      aclocalinclude="${ACLOCAL_FLAGS}"; 
      for k in ${macrodirs}; do 
        if test -d ${k}; then 
          aclocalinclude="${aclocalinclude} -I ${k}"; 
        ##else 
        ##  echo "**Warning**: No such directory `${k}'.  Ignored." 
        fi 
      done 
      if grep "^AM_GNU_GETTEXT" configure.in >/dev/null; then 
        if grep "sed.*POTFILES" configure.in >/dev/null; then 
          : do nothing -- we still have an old unmodified configure.in 
        else 
          test -r ${dr}/aclocal.m4 || touch ${dr}/aclocal.m4; 
          echo "no" | gettextize --force --copy; 
          test -r ${dr}/aclocal.m4 && %{__chmod} u+w ${dr}/aclocal.m4; 
        fi 
      fi 
      if grep "^AM_PROG_LIBTOOL" configure.in >/dev/null; then 
        %{__libtoolize} --force --copy; 
      fi 
      aclocal ${aclocalinclude}; 
      if grep "^AM_CONFIG_HEADER" configure.in >/dev/null; then 
        %{__autoheader}; 
      fi 
      echo "Running automake --gnu ${am_opt} ..."; 
      %{__automake} --add-missing --gnu ${am_opt}; 
      %{__autoconf}; 
    ); 
  fi 
done 
  %{-C:${_mydir}}%{!-C:.}/configure %{_target_platform} --prefix=%{_prefix} --exec-prefix=%{_exec_prefix} --bindir=%{_bindir} --sbindir=%{_sbindir} --sysconfdir=%{_sysconfdir} --datadir=%{_datadir} --includedir=%{_includedir} --libdir=%{_libdir} --libexecdir=%{_libexecdir} --localstatedir=%{_localstatedir} --sharedstatedir=%{_sharedstatedir} --mandir=%{_mandir} --infodir=%{_infodir} %* ; 
  %{-C:cd ${_mydir}; unset _mydir}
-14: ___build_args	-e
-14: ___build_cmd	%{?_sudo:%{_sudo} }%{?_remsh:%{_remsh} %{_remhost} }%{?_remsudo:%{_remsudo} }%{?_remchroot:%{_remchroot} %{_remroot} }%{___build_shell} %{___build_args}
-14: ___build_post	exit 0
-14: ___build_pre	
  RPM_SOURCE_DIR="%{u2p:%{_sourcedir}}"
  RPM_BUILD_DIR="%{u2p:%{_builddir}}"
  RPM_OPT_FLAGS="%{optflags}"
  RPM_ARCH="%{_arch}"
  RPM_OS="%{_os}"
  export RPM_SOURCE_DIR RPM_BUILD_DIR RPM_OPT_FLAGS RPM_ARCH RPM_OS
  RPM_DOC_DIR="%{_docdir}"
  export RPM_DOC_DIR
  RPM_PACKAGE_NAME="%{name}"
  RPM_PACKAGE_VERSION="%{version}"
  RPM_PACKAGE_RELEASE="%{release}"
  export RPM_PACKAGE_NAME RPM_PACKAGE_VERSION RPM_PACKAGE_RELEASE
  %{?buildroot:RPM_BUILD_ROOT="%{u2p:%{buildroot}}"
  export RPM_BUILD_ROOT}
  %{?_javaclasspath:CLASSPATH="%{_javaclasspath}"
  export CLASSPATH}
  
  %{verbose:set -x}%{!verbose:exec > /dev/null}
  umask 022
  cd %{u2p:%{_builddir}}
-14: ___build_shell	%{?_buildshell:%{_buildshell}}%{!?_buildshell:/bin/sh}
-14: ___build_template	#!%{___build_shell}
%{___build_pre}
%{nil}
-14: __aclocal	aclocal
-14: __ar	ar
-14: __arch_install_post	%{nil}
-14: __as	as
-14: __autoconf	autoconf
-14: __autoheader	autoheader
-14: __automake	automake
-14: __awk	gawk
-14: __bzip2	/usr/bin/bzip2
-14: __cat	/bin/cat
-14: __cc	gcc
-14: __check_files	/usr/lib/rpm/check-files %{buildroot}
-14: __chgrp	/bin/chgrp
-14: __chgrp_Rhf	%{__chgrp} -Rhf
-14: __chmod	/bin/chmod
-14: __chown	/bin/chown
-14: __chown_Rhf	%{__chown} -Rhf
-14: __cp	/bin/cp
-14: __cpio	/usr/bin/cpio
-14: __cpp	gcc -E
-14: __cxx	g++
-14: __dbi_btconfig	
  btree		
  %{__dbi_other}
  %{__dbi_perms}
%{nil}
-14: __dbi_btconfig_current	%{__dbi_btconfig}
-14: __dbi_btconfig_rebuild	%{__dbi_btconfig} %{__dbi_rebuild}
-14: __dbi_cdb	create cdb mpool mp_mmapsize=16Mb mp_size=1Mb
-14: __dbi_htconfig	
  hash		
  %{__dbi_other}
  %{__dbi_perms}
%{nil}
-14: __dbi_htconfig_current	%{__dbi_htconfig}
-14: __dbi_htconfig_rebuild	%{__dbi_htconfig} %{__dbi_rebuild}
-14: __dbi_other	%{?_tmppath:tmpdir=%{_tmppath}} %{?__dbi_cdb}
-14: __dbi_perms	perms=0644
-14: __dbi_rebuild	nofsync !log !txn !cdb
-14: __dbi_transient	%{__dbi_rebuild} temporary private
-14: __debug_install_post	
   /usr/lib/rpm/find-debuginfo.sh %{_builddir}/%{?buildsubdir}
%{nil}
-14: __file	/usr/bin/file
-14: __find_provides	/usr/lib/rpm/find-provides
-14: __find_requires	/usr/lib/rpm/find-requires
-14: __gpg	/usr/bin/gpg
-14: __gpg_check_password_cmd	%{__gpg} 
	gpg --batch --no-verbose --passphrase-fd 3 -u "%{_gpg_name}" -so -
-14: __gpg_sign_cmd	%{__gpg} 
	gpg --batch --no-verbose --no-armor --passphrase-fd 3 --no-secmem-warning 
	-u "%{_gpg_name}" -sbo %{__signature_filename} %{__plaintext_filename}
-14: __grep	/usr/bin/grep
-14: __gzip	/usr/bin/gzip
-14: __id	/usr/bin/id
-14: __id_u	%{__id} -u
-14: __install	/usr/bin/install
-14: __ld	/usr/bin/ld
-14: __libtoolize	libtoolize
-14: __ln_s	ln -s
-14: __make	/usr/bin/make
-14: __mkdir	/bin/mkdir
-14: __mkdir_p	/bin/mkdir -p
-14: __mv	/bin/mv
-14: __nm	/usr/bin/nm
-14: __objcopy	/usr/bin/objcopy
-14: __objdump	/usr/bin/objdump
-14: __os_install_post	
    %{suse_check} 
    /usr/lib/rpm/brp-compress 
    /usr/lib/rpm/brp-symlink 
%{nil}
-14: __patch	/usr/bin/patch
-14: __perl	/usr/bin/perl
-14: __perl_provides	/usr/lib/rpm/perl.prov
-14: __perl_requires	/usr/lib/rpm/perl.req
-14: __pgp	/usr/bin/pgp
-14: __pgp5_check_password_cmd	%{__pgp} 
	pgps +batchmode=on +verbose=0 +armor=off "%{_pgp_name}" -f
-14: __pgp5_sign_cmd	%{__pgp} 
	pgps +batchmode=on +verbose=0 +armor=off 
	"+myname=%{_pgp_name}" -b %{__plaintext_filename} -o %{__signature_filename}
-14: __pgp_check_password_cmd	%{__pgp} 
	pgp +batchmode=on +verbose=0 "%{_pgp_name}" -sf
-14: __pgp_sign_cmd	%{__pgp} 
	pgp +batchmode=on +verbose=0 +armor=off 
	"+myname=%{_pgp_name}" -sb %{__plaintext_filename} %{__signature_filename}
-14: __python	/usr/bin/python
-14: __ranlib	ranlib
-14: __remsh	%{__rsh}
-14: __rm	/bin/rm
-14: __rsh	/usr/bin/rsh
-14: __sed	/usr/bin/sed
-14: __spec_build_args	%{___build_args}
-14: __spec_build_body	%{___build_body}
-14: __spec_build_cmd	%{___build_cmd}
-14: __spec_build_post	%{___build_post}
-14: __spec_build_pre	%{___build_pre}
%{?buildroot:  %__rm -rf "$RPM_BUILD_ROOT"
  %__mkdir_p `dirname "$RPM_BUILD_ROOT"`
  %__mkdir "$RPM_BUILD_ROOT"
}
-14: __spec_build_shell	%{___build_shell}
-14: __spec_build_template	#!%{__spec_build_shell}
%{__spec_build_pre}
%{nil}
-14: __spec_check_args	%{___build_args}
-14: __spec_check_body	%{___build_body}
-14: __spec_check_cmd	%{___build_cmd}
-14: __spec_check_post	%{___build_post}
-14: __spec_check_pre	%{___build_pre}
-14: __spec_check_shell	%{___build_shell}
-14: __spec_check_template	#!%{__spec_check_shell}
%{__spec_check_pre}
%{nil}
-14: __spec_clean_args	%{___build_args}
-14: __spec_clean_body	%{___build_body}
-14: __spec_clean_cmd	%{___build_cmd}
-14: __spec_clean_post	%{___build_post}
-14: __spec_clean_pre	%{___build_pre}
-14: __spec_clean_shell	%{___build_shell}
-14: __spec_clean_template	#!%{__spec_clean_shell}
%{__spec_clean_pre}
%{nil}
-14: __spec_install_args	%{___build_args}
-14: __spec_install_body	%{___build_body}
-14: __spec_install_cmd	%{___build_cmd}
-14: __spec_install_post	
    %{?__debug_package:%{__debug_install_post}}
    %{__arch_install_post}
    %{__os_install_post}
%{nil}
-14: __spec_install_pre	%{___build_pre}
-14: __spec_install_shell	%{___build_shell}
-14: __spec_install_template	#!%{__spec_install_shell}
%{__spec_install_pre}
%{nil}
-14: __spec_prep_args	%{___build_args}
-14: __spec_prep_body	%{___build_body}
-14: __spec_prep_cmd	%{___build_cmd}
-14: __spec_prep_post	%{___build_post}
-14: __spec_prep_pre	%{___build_pre}
-14: __spec_prep_shell	%{___build_shell}
-14: __spec_prep_template	#!%{__spec_prep_shell}
%{__spec_prep_pre}
%{nil}
-14: __spec_rmbuild_args	%{___build_args}
-14: __spec_rmbuild_body	%{___build_body}
-14: __spec_rmbuild_cmd	%{___build_cmd}
-14: __spec_rmbuild_post	%{___build_post}
-14: __spec_rmbuild_pre	%{___build_pre}
-14: __spec_rmbuild_shell	%{___build_shell}
-14: __spec_rmbuild_template	#!%{__spec_rmbuild_shell}
%{__spec_rmbuild_pre}
%{nil}
-14: __ssh	/usr/bin/ssh
-14: __strip	/usr/bin/strip
-14: __tar	/bin/tar
-14: __unzip	/usr/bin/unzip
-14: __vsflags	0
-14: _arch	i386
-14: _bhA	RPMS
-14: _bhN	@(SRPMS|i386|alpha|sparc|s390|ia64)
-14: _bhVR	RedHat
-14: _bhcoll	@(7.3|7.2|7.1|7.1sbe|7.1k|7.0|7.01j|7.0j|7.0sbe|7.0tc|6.2|6.2ha|6.2ee|6.1|6.0|5.2|5.1|5.0)
-14: _bhpath	file://localhost/mnt/dist
-14: _binary_payload	w9.bzdio
-14: _bindir	%{_exec_prefix}/bin
-14: _build	%{_host}
-14: _build_alias	%{_host_alias}
-14: _build_arch	i386
-14: _build_cpu	%{_host_cpu}
-14: _build_name_fmt	%%{ARCH}/%%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm
-14: _build_os	%{_host_os}
-14: _build_vendor	%{_host_vendor}
-14: _builddir	%{_topdir}/BUILD
-14: _buildshell	/bin/sh
-14: _bzip2bin	%{__bzip2}
-14: _cache_dbpath	/var/spool/up2date/cache
-14: _datadir	%{_prefix}/share
-14: _dbapi	3
-14: _dbapi_rebuild	3
-14: _dbi_btconfig	
  %{?_rpmdb_rebuild:%{__dbi_btconfig_rebuild}}
  %{!?_rpmdb_rebuild:%{__dbi_btconfig_current}}
%{nil}
-14: _dbi_config	%{_dbi_htconfig} nofsync
-14: _dbi_config_Depends	%{_dbi_htconfig} temporary private nofsync
-14: _dbi_config_Dirnames	%{_dbi_btconfig} nofsync
-14: _dbi_config_Installtid	%{_dbi_btconfig} nofsync
-14: _dbi_config_Packages	%{_dbi_htconfig} lockdbfd
-14: _dbi_config_Provideversion	%{_dbi_btconfig} nofsync
-14: _dbi_config_Removetid	%{_dbi_btconfig} nofsync
-14: _dbi_config_Requireversion	%{_dbi_btconfig} nofsync
-14: _dbi_htconfig	
  %{?_rpmdb_rebuild:%{__dbi_htconfig_rebuild}}
  %{!?_rpmdb_rebuild:%{__dbi_htconfig_current}}
%{nil}
-14: _dbi_tags	Packages:Name:Basenames:Group:Requirename:Providename:Conflictname:Triggername:Dirnames:Requireversion:Provideversion:Installtid:Sigmd5:Sha1header:Filemd5s:Depends:Pubkeys
-14: _dbpath	%{_var}/lib/rpm
-14: _dbpath_rebuild	%{_dbpath}
-14: _defaultdocdir	%{_usr}/share/doc/packages
-14: _docdir_fmt	%%{NAME}
-14: _exec_prefix	%{_prefix}
-14: _fixgroup	[ `%{__id_u}` = '0' ] && %{__chgrp_Rhf} root
-14: _fixowner	[ `%{__id_u}` = '0' ] && %{__chown_Rhf} root
-14: _fixperms	%{__chmod} -Rf a+rX,g-w,o-w
-14: _gnu	-gnu
-14: _gzipbin	%{__gzip}
-14: _host	i686-suse-linux
-14: _host_alias	i686-suse-linux%{nil}
-14: _host_cpu	i686
-14: _host_os	linux
-14: _host_vendor	suse
-14: _includedir	%{_prefix}/include
-14: _infodir	%{_prefix}/share/info
-14: _initrddir	%{_sysconfdir}/init.d
-14: _install_langs	all
-14: _install_script_path	/sbin:/bin:/usr/sbin:/usr/bin:/usr/X11R6/bin
-14: _instchangelog	5
-14: _javadir	%{_datadir}/java
-14: _javadocdir	%{_datadir}/javadoc
-14: _jnidir	%{_libdir}/java
-14: _jvmdir	%{_libdir}/jvm
-14: _jvmjardir	%{_libdir}/jvm-exports
-14: _jvmprivdir	%{_libdir}/jvm-private
-14: _lib	lib
-14: _libdir	%{_exec_prefix}/%{_lib}
-14: _libexecdir	%{_exec_prefix}/libexec
-14: _localstatedir	/var
-14: _mandir	%{_prefix}/share/man
-14: _missing_doc_files_terminate_build	1
-14: _multilibno	1
-14: _multilibpatt	(/%{_lib}|/usr/%{_lib}(|/gconv)|/usr/local/%{_lib}|/usr/X11R6/%{_lib}|/opt/%{_lib})/[^/]*\.([oa]|la|so[0-9.]*)$
-14: _oldincludedir	/usr/include
-14: _os	linux
-14: _package_version	30005
-14: _pgpbin	%{__pgp}
-15: _preScriptEnvironment	
RPM_SOURCE_DIR="%{_sourcedir}"
RPM_BUILD_DIR="%{_builddir}"
RPM_OPT_FLAGS="%{optflags}"
RPM_ARCH="%{_arch}"
RPM_OS="%{_os}"
export RPM_SOURCE_DIR RPM_BUILD_DIR RPM_OPT_FLAGS RPM_ARCH RPM_OS
RPM_DOC_DIR="%{_docdir}"
export RPM_DOC_DIR
RPM_PACKAGE_NAME="%{name}"
RPM_PACKAGE_VERSION="%{version}"
RPM_PACKAGE_RELEASE="%{release}"
export RPM_PACKAGE_NAME RPM_PACKAGE_VERSION RPM_PACKAGE_RELEASE
%{?buildroot:RPM_BUILD_ROOT="%{buildroot}"
export RPM_BUILD_ROOT
}
-14: _prefix	/usr
-14: _query_all_fmt	%%{name}-%%{version}-%%{release}
-14: _query_selector_match	default
-14: _repackage_all_erasures	0
-14: _repackage_dir	/var/spool/repackage
-14: _repackage_name_fmt	%%{NAME}-%%{VERSION}-%%{RELEASE}.%%{ARCH}.rpm
-14: _repackage_root	%{nil}
-14: _rpmdir	%{_topdir}/RPMS
-14: _rpmfilename	%{_build_name_fmt}
-14: _sbindir	%{_exec_prefix}/sbin
-14: _sharedstatedir	%{_prefix}/com
-14: _signature	none
-14: _smp_mflags	%([ -z "$RPM_BUILD_NCPUS" ] \
	&& RPM_BUILD_NCPUS="`/usr/bin/getconf _NPROCESSORS_ONLN`"; \
	[ "$RPM_BUILD_NCPUS" -gt 1 ] && echo "-j$RPM_BUILD_NCPUS")
-14: _sourcedir	%{_topdir}/SOURCES
-14: _specdir	%{_topdir}/SPECS
-14: _srcrpmdir	%{_topdir}/SRPMS
-14: _sysconfdir	/etc
-11: _target	i586-linux
-14: _target_alias	%{_host_alias}
-11= _target_cpu	i586
-11= _target_os	linux
-14: _target_platform	%{_target_cpu}-%{_vendor}-%{_target_os}
-14: _target_vendor	%{_host_vendor}
-14: _tmppath	%{_topdir}/TMP
-14: _topdir	/home/internet/RPM_TOP_DIR
-14: _transaction_color	0
-14: _unpackaged_files_terminate_build	1
-14: _unzipbin	%{__unzip}
-14: _use_internal_dependency_generator	0
-14: _usr	/usr
-14: _usrsrc	%{_usr}/src
-14: _var	/var
-14: _vendor	suse
-14: _vsflags_build	%{__vsflags}
-14: _vsflags_erase	%{__vsflags}
-14: _vsflags_install	%{__vsflags}
-14: _vsflags_query	%{__vsflags}
-14: _vsflags_rebuilddb	%{__vsflags}
-14: _vsflags_up2date	%{__vsflags}
-14: _vsflags_verify	%{__vsflags}
-14: add_jvm_extension	JAVA_LIBDIR=%{buildroot}/%{_javadir}	%{_bindir}/jvmjar -l
-14: add_start_if_needed	
   set -- %{?*} 
    while [ ${#*} -gt 0 ] ; do 
	SCRIPTNAME=$1 
	STARTVAR=$2 
	shift 2 
	test -n "$STARTVAR" -a -n "$SCRIPTNAME" || { 
	    echo "STARTVAR or SCRIPTNAME unknown" 
	    exit 1 
	} 
	if test "$FIRST_ARG" = "1" -o "$REMOVED_START" = "yes" -o "$FORCE_YES" = "1" ; then 
	  if test -n "$YAST_IS_RUNNING" ; then 
	    INSSERV_FORCE="-f" 
	  else 
	    INSSERV_FORCE="" 
	  fi 
	  if test "${!STARTVAR}" = "yes" -o "$FORCE_YES" = "1" ; then 
	    sbin/insserv $INSSERV_FORCE etc/init.d/$SCRIPTNAME 
	  else 
	    sbin/insserv $INSSERV_FORCE -r etc/init.d/$SCRIPTNAME 
	  fi 
	fi 
    done
-14: ant	JAVA_HOME=%{java_home} ant
-14: cflags_profile_feedback	-fbranch-probabilities
-14: cflags_profile_generate	-fprofile-arcs
-14: configure	
  CFLAGS="${CFLAGS:-%optflags}" ; export CFLAGS ; 
  CXXFLAGS="${CXXFLAGS:-%optflags}" ; export CXXFLAGS ; 
  FFLAGS="${FFLAGS:-%optflags}" ; export FFLAGS ; 
  ./configure --host=%{_host} --build=%{_build} \
	--target=%{_target_platform} \
	--program-prefix=%{?_program_prefix} \
 	--prefix=%{_prefix} \
	--exec-prefix=%{_exec_prefix} \
	--bindir=%{_bindir} \
	--sbindir=%{_sbindir} \
	--sysconfdir=%{_sysconfdir} \
	--datadir=%{_datadir} \
	--includedir=%{_includedir} \
	--libdir=%{_libdir} \
	--libexecdir=%{_libexecdir} \
	--localstatedir=%{_localstatedir} \
	--sharedstatedir=%{_sharedstatedir} \
	--mandir=%{_mandir} \
	--infodir=%{_infodir}
-14: configure_kernel_source	
	if test -d /usr/src/linux ; then 
	    pushd /usr/src/linux 
	    test -f .config || cp arch/%_arch/defconfig.default .config 
	    yes "" | make oldconfig 
	    make dep 
	    popd 
	fi 
	%nil
-14: debug_package	
%ifnarch noarch
%global __debug_package 1
%package debuginfo
Summary: Debug information for package %{name}
Group: Development/Debug
AutoReqProv: 0
%description debuginfo
This package provides debug information for package %{name}.
Debug information is useful when developing applications that use this
package or when debugging this package.
%files debuginfo -f debugfiles.list
%defattr(-,root,root)
%endif
%{nil}
-14: do_profiling	1
-14: do_real_fillup	
    TEMPLATE_DIR=var/adm/fillup-templates 
    SYSC_TEMPLATE=$TEMPLATE_DIR/sysconfig.$PNAME 
    RC_TEMPLATE=$TEMPLATE_DIR/rc.config.$PNAME 
    SD_NAME="" 
    if [ -x bin/fillup ] ; then 
	%{sysc_fillup} 
	# remove the START_ variables from the base fillup template 
	if [ -f $RC_TEMPLATE.del -a -f $RC_TEMPLATE ] ; then 
	  bin/fillup -q -r -i  $RC_TEMPLATE $RC_TEMPLATE.del /dev/null 
	  mv $RC_TEMPLATE.new $RC_TEMPLATE 
	fi 
	if [ -f etc/rc.config ] ; then 
	  %{rc_fillup} 
	  # remove the deprecated START_ variables from rc.config 
	  if [ -f $TEMPLATE_DIR/rc.config.$PNAME.del ] ; then 
	    rm -f etc/rc.config.xtract 
	    bin/fillup -q -r -i etc/rc.config $RC_TEMPLATE.del etc/rc.config.xtract 
	    if [ -f etc/rc.config.xtract ] ; then 
	      . etc/rc.config.xtract 
	    fi 
	    rm -f etc/rc.config.xtract $RC_TEMPLATE.del 
	    if [ -f etc/rc.config.new ] ; then 
	      cmp -s etc/rc.config.new etc/rc.config || REMOVED_START=yes 
	      mv etc/rc.config.new etc/rc.config 
	    fi 
	  fi 
	fi 
    else 
	echo "ERROR: fillup not found. This should not happen. Please compare" 
	echo "etc/rc.config and $TEMPLATE_DIR/rc.config.$PNAME and" 
	echo "update by hand." 
    fi
-14: fillup_and_insserv(finpsyY)	
  test -n "$FIRST_ARG" || FIRST_ARG=$1 
  %{-Y:FORCE_YES=1}%{!-Y:FORCE_YES=0} 
  REMOVED_START=no 
  set -- %{?*} 
  %{-n:PNAME=$1 ; shift }%{!-n:PNAME=%{name}} 
  INSSRV_ARRAY="" 
  while [ ${#*} -gt 0 ] ; do 
    SCRIPTNAME=$1 
    shift 
    %{-s:STARTVAR=$1 ; shift} 
    %{!-s:STARTVAR=START_`echo $SCRIPTNAME | tr a-z.- A-Z__`} 
    SV_B='^### BEGIN INIT INFO' 
    SV_E='^### END INIT INFO' 
    SV_KW=X-UnitedLinux-Default-Enabled 
    SV_VAL=`sed -n -e "/$SV_B/,/$SV_E/{/^# $SV_KW:[[:space:]]*\([^[:space:]]*\).*/s//\1/p;}" < etc/init.d/$SCRIPTNAME` 
    test -n "$SV_VAL" || SV_VAL=%{-y:"yes"}%{!-y:"no"} 
    eval $STARTVAR=$SV_VAL 
    test -n "$STARTVAR" -a -n "$SCRIPTNAME" || { 
	echo "STARTVARIABLE or SCRIPTNAME unknown" 
	exit 1 
    } 
    INSSRV_ARRAY="$INSSRV_ARRAY $SCRIPTNAME $STARTVAR" 
    %{!-f:%{!-i:grep -q "$STARTVAR=" var/adm/fillup-templates/rc.config.$PNAME.del 2>/dev/null || 
	echo -e "#\n# Start service $SCRIPTNAME\n#\n$STARTVAR=\"${!STARTVAR}\"\n\n" >> var/adm/fillup-templates/rc.config.$PNAME.del } } 
  done 
  %{!-f: %{do_real_fillup}} 
  %{!-i: %{add_start_if_needed $INSSRV_ARRAY } }
-14: fillup_only(dans)	
  %{-n:PNAME=%{1}}%{!-n:PNAME=%{name}} 
  %{-s:SUBPNAME=-%{2}}%{!-s:SUBPNAME=%{-a:-%{name}}} 
    TEMPLATE_DIR=var/adm/fillup-templates 
    SYSC_TEMPLATE=$TEMPLATE_DIR/sysconfig.$PNAME$SUBPNAME 
    RC_TEMPLATE=$TEMPLATE_DIR/rc.config.$PNAME 
    SD_NAME="" 
    %{-d:%{-s:SD_NAME=%{3}/}%{!-s:SD_NAME=%{2}/}} 
    if [ -x bin/fillup ] ; then 
	%{sysc_fillup} 
	%{rc_fillup} 
    else 
	echo "ERROR: fillup not found. This should not happen. Please compare" 
	echo "etc/rc.config and $RC_TEMPLATE and" 
	echo "update by hand." 
    fi
-14: fillup_prereq	fillup coreutils
-14: find_lang	/usr/lib/rpm/find-lang.sh %{buildroot}
-14: insserv_cleanup	
	sbin/insserv etc/init.d
-14: insserv_force_if_yast	
	if test -n "$YAST_IS_RUNNING" ; then 
            INSSERV_FORCE="-f" 
	else 
	    INSSERV_FORCE="" 
	fi 
	sbin/insserv $INSSERV_FORCE %{?*}
-14: insserv_prereq	insserv sed devs
-14: install_info(:-:)	
	ALL_ARGS=(%{**}) 
	NUM_ARGS=${#ALL_ARGS[@]} 
	if test -x sbin/install-info ; then 
	    if test -e "${ALL_ARGS[$((NUM_ARGS-1))]}" ; then 
		sbin/install-info "${ALL_ARGS[@]}" 
	    fi 
	fi ;
-14: install_info_delete(:-:)	
	ALL_ARGS=(%{**}) 
	NUM_ARGS=${#ALL_ARGS[@]} 
	if test -x sbin/install-info ; then 
	   if ! test -e "${ALL_ARGS[$((NUM_ARGS-1))]}" ; then 
		sbin/install-info --quiet --delete "${ALL_ARGS[@]}" 
	   fi ; 
	fi ;
-14: install_info_prereq	info
-14: is_plus	%(if test -f /.buildenv ; then source /.buildenv ; if [[ "$BUILD_BASENAME" == *+kde ]] ; then echo 1 ; else echo 0 ; fi ; else echo 0 ; fi)
-14: ix86	i386 i486 i586 i686 athlon
-14: jar	%{java_home}/bin/jar
-14: java	%(. %{_javadir}-utils/java-functions; set_javacmd; echo $JAVACMD)
-14: java_home	%(. %{_javadir}-utils/java-functions; set_jvm; echo $JAVA_HOME)
-14: javac	%{java_home}/bin/javac
-14: javadoc	%{java_home}/bin/javadoc
-14: jpackage_script	
install -d -m 755 $RPM_BUILD_ROOT%{_bindir}
cat > $RPM_BUILD_ROOT%{_bindir}/%5 << EOF 
#!/bin/sh
#
# %{name} script
# JPackage Project <http://www.jpackage.org/>

# Source functions library
. %{_javadir}-utils/java-functions

# Source system prefs
if [ -f %{_sysconfdir}/java/%{name}.conf ] ; then
  . %{_sysconfdir}/java/%{name}.conf
fi

# Source user prefs
if [ -f \$HOME/.%{name}rc ] ; then
  . \$HOME/.%{name}rc
fi

# Configuration
MAIN_CLASS=%1
BASE_FLAGS=%2
BASE_OPTIONS=%3
BASE_JARS="%(echo %4 | sed -e 's,:, ,g')"

# Set parameters
set_jvm
set_classpath \$BASE_JARS
set_flags \$BASE_FLAGS
set_options \$BASE_OPTIONS

# Let's start
run "\$@"
EOF
-14: makeinstall	make DESTDIR=%{?buildroot:%{buildroot}} install
-14: nil	%{!?nil}
-11: optflags	-O2 -g -march=i586 -mcpu=i686 -fmessage-length=0
-14: perl_archlib	%(eval "`perl -V:installarchlib`"; echo $installarchlib)
-14: perl_installarchlib	%(perl -V:installarchlib | sed "s!.*='!!;s!'.*!!")
-14: perl_installman1dir	%(perl -V:installman1dir | sed "s!.*='!!;s!'.*!!")
-14: perl_installman3dir	%(perl -V:installman3dir | sed "s!.*='!!;s!'.*!!")
-14: perl_make_install	make DESTDIR=$RPM_BUILD_ROOT install_vendor
-14: perl_man1dir	%(perl -V:man1dir | sed "s!.*='!!;s!'.*!!")
-14: perl_man1ext	%(perl -V:man1ext | sed "s!.*='!!;s!'.*!!")
-14: perl_man3dir	%(perl -V:man3dir | sed "s!.*='!!;s!'.*!!")
-14: perl_man3ext	%(perl -V:man3ext | sed "s!.*='!!;s!'.*!!")
-14: perl_prefix	%{buildroot}
-14: perl_process_packlist(n:)	
  mkdir -p $RPM_BUILD_ROOT/var/adm/perl-modules 
  test -f $RPM_BUILD_ROOT%{perl_archlib}/perllocal.pod && { sed -e "s@$RPM_BUILD_ROOT@@g" < $RPM_BUILD_ROOT%{perl_archlib}/perllocal.pod > $RPM_BUILD_ROOT/var/adm/perl-modules/%{-n:%{-n*}}%{!-n:%{name}} ; } ; 
  test -n "$RPM_BUILD_ROOT" -a -d $RPM_BUILD_ROOT/%perl_sitearch/auto && find $RPM_BUILD_ROOT/%perl_sitearch/auto -name .packlist -print0 | xargs -0 -r perl -spi -e "s@$RPM_BUILD_ROOT@@g" ; 
  test -n "$RPM_BUILD_ROOT" -a -d $RPM_BUILD_ROOT/%perl_vendorarch/auto && find $RPM_BUILD_ROOT/%perl_vendorarch/auto -name .packlist -print0 | xargs -0 -r perl -spi -e "s@$RPM_BUILD_ROOT@@g" ; 
  rm -f $RPM_BUILD_ROOT%{perl_archlib}/perllocal.pod 
  %nil
-14: perl_sitearch	%(eval "`perl -V:installsitearch`"; echo $installsitearch)
-14: perl_sitelib	%(perl -V:sitelib | sed "s!.*='!!;s!'.*!!")
-14: perl_vendorarch	%(perl -V:vendorarch | sed "s!.*='!!;s!'.*!!")
-14: perl_vendorlib	%(perl -V:vendorlib | sed "s!.*='!!;s!'.*!!")
-14: perl_version	%(perl -V:version | sed "s!.*='!!;s!'.*!!")
-14: py_compile(O)	
find %1 -name '*.pyc' -exec rm -f {} \; 
python -c "import sys, os, compileall; br='%{buildroot}'; compileall.compile_dir(sys.argv[1], ddir=br and (sys.argv[1][len(os.path.abspath(br)):]+'/') or None)" %1 
%{-O: 
find %1 -name '*.pyo' -exec rm -f {} \; 
python -O -c "import sys, os, compileall; br='%{buildroot}'; compileall.compile_dir(sys.argv[1], ddir=br and (sys.argv[1][len(os.path.abspath(br)):]+'/') or None)" %1 
}
-14: py_incdir	%{py_prefix}/include/python%{py_ver}
-14: py_libdir	%{py_prefix}/%{_lib}/python%{py_ver}
-14: py_prefix	%(python -c "import sys; print sys.prefix" 2>/dev/null || echo PYTHON-NOT-FOUND)
-14: py_requires(d)	
%define minver %py_ver 
%define maxver %(python -c "import sys; a,b=sys.version_info[:2]; print '%%d.%%d'%%(a,b+1)" 2>/dev/null || echo PYTHON-NOT-FOUND) 
BuildRequires: python %{-d:python-devel} 
PreReq: python >= %minver, python < %maxver
-14: py_sitedir	%{py_libdir}/site-packages
-14: py_ver	%(python -c "import sys; v=sys.version_info[:2]; print '%%d.%%d'%%v" 2>/dev/null || echo PYTHON-NOT-FOUND)
-14: rc_fillup	
	# maybe the fillup template for rc.config is old, make sure we do not readd stuff here 
	if [ -f $SYSC_TEMPLATE -a -f $RC_TEMPLATE ] ; then 
	  bin/fillup -q -r -i $RC_TEMPLATE $SYSC_TEMPLATE /dev/null 
	  mv $RC_TEMPLATE.new $RC_TEMPLATE 
	fi 
	# do the normal fillup for the rc.config variables 
	if [ -f $RC_TEMPLATE ] ; then 
	  bin/fillup -q -d = etc/rc.config $RC_TEMPLATE 
	fi
-14: remove_and_set(n:y)	
  %{-n:PNAME=%{-n*}}%{!-n:PNAME=%{name}} 
  DEF_VAL=%{-y:"yes"}%{!-y:"no"} 
  DEL_TEMPL=var/adm/fillup-templates/$PNAME.del 
  rm -f $DEL_TEMPL 
  for var in %{?*} ; do 
    echo -e "#\n$var=$DEF_VAL\n" >> $DEL_TEMPL 
  done 
  if [ -f etc/rc.config ]  ; then 
    bin/fillup -q -t -r -i -d "=" etc/rc.config $DEL_TEMPL etc/rc.config.xtract 
    test -f etc/rc.config.new && mv etc/rc.config.new etc/rc.config 
  fi 
  if [ -f etc/sysconfig/$PNAME ] ; then 
    bin/fillup -q -t -r -i -d "=" etc/sysconfig/$PNAME $DEL_TEMPL etc/rc.config.xtract.too 
    test -f etc/sysconfig/$PNAME.new && mv etc/sysconfig/$PNAME.new etc/sysconfig/$PNAME 
  fi  
  for i in $DEL_TEMPL etc/rc.config.xtract etc/rc.config.xtract.too ; do 
    if [ -f $i ] ; then 
     . $i 
     rm -f $i 
    fi 
  done
-14: rename_sysconfig_variable(f:)	
	%{!-f:FILE=etc/rc.config}%{-f:FILE=%{-f*}} 
	if [ -f $FILE ] ; then 
	  sed -e "s/^%{1}=/%{2}=/" $FILE > $FILE.new 
	  mv $FILE.new $FILE 
	fi
-14: requires_eq	%(LC_ALL="C" echo '%*' | xargs -r rpm -q --qf 'Requires: %%{name} = %%{epoch}:%%{version}\n' | sed -e 's/ (none):/ /' -e 's/ 0:/ /' | grep -v "is not")
-14: restart_on_update	
	test -n "$FIRST_ARG" || FIRST_ARG=$1 
	if test "$FIRST_ARG" -ge 1 ; then 
	   test -f /etc/sysconfig/services && . /etc/sysconfig/services 
           if test "$YAST_IS_RUNNING" != "instsys" -a "$DISABLE_RESTART_ON_UPDATE" != yes ; then 
              for service in %{?*} ; do 
                 /etc/init.d/$service try-restart > /dev/null || : 
              done 
           fi 
        fi 
	%nil
-14: run_ldconfig	/sbin/ldconfig
-14: run_permissions	
	if test "$YAST_IS_RUNNING" != "instsys" ; then 
	    if test -x /sbin/SuSEconfig -a -f /sbin/conf.d/SuSEconfig.permissions ; then 
		/sbin/SuSEconfig --module permissions 
	    fi 
	fi 
	%nil
-14: run_suseconfig(m:)	
   %{!-m:echo -e "\nERROR: missing parameter for macro run_suseconfig\n" ; exit 1 ; } 
   if test "$YAST_IS_RUNNING" != "instsys" ; then 
     if test -x /sbin/SuSEconfig -a -f /sbin/conf.d/SuSEconfig.%{-m*} ; then 
       /sbin/SuSEconfig --module %{-m*} 
     else 
       echo -e "\nERROR: SuSEconfig or requested SuSEconfig module not present!\n" ; exit 1 
     fi 
   fi 
   %nil
-14: run_suseconfig_fonts(c)	
  if test -x /sbin/conf.d/SuSEconfig.fonts ; then 
    %run_suseconfig -m fonts 
  fi 
  if test -x /sbin/conf.d/SuSEconfig.pango ; then 
    %run_suseconfig -m pango 
  fi 
  %{-c:if test -x /sbin/conf.d/SuSEconfig.ghostscript-cjk ; then 
         %run_suseconfig -m ghostscript-cjk 
       fi} 
  %nil
-14: save_rc_config_d_was_in_filelist(n)	
  %{-n:PNAME=%{?*}}%{!-n:PNAME=%{name}} 
  mkdir -p etc/sysconfig 
  if [ -f etc/rc.config.d/$PNAME.rc.config -a ! -f etc/sysconfig/$PNAME ] ; then 
    cp etc/rc.config.d/$PNAME.rc.config etc/sysconfig/$PNAME 
  fi
-15: sigtype	none
-14: sles_version	0
-14: stop_on_removal	
        test -n "$FIRST_ARG" || FIRST_ARG=$1 
        if test "$FIRST_ARG" = "0" ; then 
	   test -f /etc/sysconfig/services && . /etc/sysconfig/services 
           if test "$YAST_IS_RUNNING" != "instsys" -a "$DISABLE_STOP_ON_REMOVAL" != yes ; then 
              for service in %{?*} ; do 
                 /etc/init.d/$service stop > /dev/null 
              done 
           fi 
        fi 
        %nil
-14: suse_check	
        %{?buildroot:RPM_BUILD_ROOT="%{buildroot}"
        export RPM_BUILD_ROOT}
        test -x /usr/sbin/Check -a $UID = 0 -o -x /usr/sbin/Check -a ! -z "$RPM_BUILD_ROOT" && {
            echo "I call /usr/sbin/Check..."
            /usr/sbin/Check
        }
-14: suse_update_config(fcl)	
    AUTOMAKE_DIR=/usr/share/automake 
    [ -d $AUTOMAKE_DIR ] || AUTOMAKE_DIR=/usr/share/automake* 
    %{!-c:
      [ -d $AUTOMAKE_DIR ] || { 
        echo 'Please, install automake.' 
        exit 1 
      } 
    } 
    for d in . %{?*}; do 
      %{!-c:
        for f in config.sub config.guess; do 
          if test -f $d/$f -a ! $d/$f -ef $AUTOMAKE_DIR/$f ; then 
            %{!-f:[ $d/$f -nt $AUTOMAKE_DIR/$f ] ||} cp -f $AUTOMAKE_DIR/$f $d/$f 
          fi 
	  if test -d $d -a ! -f $d/depcomp -a -f $AUTOMAKE_DIR/depcomp ; then 
	    cp -f $AUTOMAKE_DIR/depcomp $d/depcomp 
	    echo "please add depcomp to sources for new automake!" 
	  fi 
	  if test -f $d/missing -a ! $d/missing -ef $AUTOMAKE_DIR/missing ; then 
	     cp -f $AUTOMAKE_DIR/missing $d/missing 
	  fi 
        done 
      } 
      %{!-l:
        for f in ltconfig ltmain.sh; do 
          if test -f $d/$f; then 
	    sed 's/linux-gnu\([^*][^*]*\)\*/linux*\1*/g; s/linux-gnu/linux/g; s,/lib\>,/%_lib,g; s,/%_lib\([$-]\),/lib\1,g' $d/$f > $d/$f-$$ && 
	    mv -f $d/$f-$$ $d/$f 
	    chmod +x $d/$f 
          fi 
        done 
      } 
    done
-14: suse_update_desktop_file(cinrud)	
  /usr/lib/rpm/suse_update_desktop_file.sh %{-c:-c} %{-i:-i} %{-n:-n} %{-r:-r} %{-u:-u} %{-d:-d} %* || exit 1 
  %nil
-14: suse_update_libdir	
   if [ %_lib != lib ]; then 
     for file in %{?*} ; do 
        [ ! -e $file ] && echo "Error:  $file does not exist!" && exit -1 
        [ -e $file.nolib64 ] && echo "Error:  $file.nolib64 already exists!" && exit -1 
        cp $file $file.nolib64 
        echo "patching $file" 
        sed -e "s,/lib\>,/%_lib,g" $file.nolib64 | sed -e "s,/%_lib/cpp,/lib/cpp,; s,/usr/%_lib/perl,/usr/lib/perl, ; s,/%_lib\([$-]\),/lib\1,g" > $file 
        rm -f $file.nolib64 
     done; 
   fi ;
-14: suse_version	930
-14: suseconfig_fonts_prereq	perl aaa_base
-14: sysc_fillup	
	if [ -f $SYSC_TEMPLATE ] ; then 
	    echo "Updating etc/sysconfig/$SD_NAME$PNAME..." 
	    if [ ! -d etc/sysconfig/$SD_NAME ] ; then 
		mkdir -p etc/sysconfig/$SD_NAME 
	    fi 
	    if [ -f etc/rc.config.d/$PNAME.rc.config ] ; then 
		if [ -f etc/sysconfig/$SD_NAME$PNAME ] ; then 
		    bin/fillup -q etc/sysconfig/$SD_NAME$PNAME etc/rc.config.d/$PNAME.rc.config 
		    rm -f etc/rc.config.d/$PNAME.rc.config 
		else 
		    mv etc/rc.config.d/$PNAME.rc.config etc/sysconfig/$SD_NAME$PNAME 
		fi 
	    fi 
	    if [ ! -f etc/rc.config ] ; then 
		test -f etc/sysconfig/$SD_NAME$PNAME || touch etc/sysconfig/$SD_NAME$PNAME 
		bin/fillup -q etc/sysconfig/$SD_NAME$PNAME $SYSC_TEMPLATE 
	    else 
	        if [ ! -f etc/sysconfig/$SD_NAME$PNAME ] ; then 
		    bin/fillup -q -r -i etc/rc.config $SYSC_TEMPLATE etc/sysconfig/$SD_NAME$PNAME 
	        else 
		    bin/fillup -q -r -i etc/rc.config $SYSC_TEMPLATE etc/sysconfig/$SD_NAME$PNAME.tmp 
		    bin/fillup -q etc/sysconfig/$SD_NAME$PNAME etc/sysconfig/$SD_NAME$PNAME.tmp 
		    rm -f etc/sysconfig/$SD_NAME$PNAME.tmp 
	        fi 
	        if [ -f etc/rc.config.new ] ; then 
		    mv etc/rc.config.new etc/rc.config 
	        fi 
	    fi
	fi
-14: tcl_version	%(echo 'puts [package require Tcl]' | tclsh)
-14: ul_version	0
-14: verify_permissions(:-:)	
   if test -f /etc/sysconfig/security ; then 
      source /etc/sysconfig/security 
   fi 
   PERMFILES="/etc/permissions" 
   for PERMEXT in $PERMISSION_SECURITY ; do 
     if test -f /etc/permissions.$PERMEXT ; then 
       PERMFILES="$PERMFILES /etc/permissions.$PERMEXT" 
     fi 
   done 
   /usr/bin/chkstat -n %{**} $PERMFILES 1>&2 
   %nil
======================== active 314 empty 0

--------------040506090003040504070003--
